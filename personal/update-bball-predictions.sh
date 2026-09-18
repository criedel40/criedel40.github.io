#!/bin/bash
# Publish today's FORECASTSv2.0 game-day forecast to this site (latest.json, the daily
# archive JSON, the figure manifest, the figures, and record.json from the bet ledger),
# then show what changed.  Grades yesterday's sheet first (results from the current-season
# files, closing lines from the hourly odds log) and fills in any older pending games.
# Run AFTER `python -m betting.forecast_today --date <date> ...` has written
# FORECASTSv2.0/artifacts/forecasts/<date>/. Usage: ./update-bball-predictions.sh [YYYYMMDD]
set -e
PROJECT=/home/criedel/NEW-AI-BBALL/SCORE/FORECASTSv2.0
SITE_DIR="$(cd "$(dirname "$0")" && pwd)"
DATE="${1:-$(date +%Y%m%d)}"
YESTERDAY=$(date -d "${DATE:0:4}-${DATE:4:2}-${DATE:6:2} -1 day" +%Y%m%d)
MONTH=$((10#${DATE:4:2})); SEASON=${DATE:0:4}; [ "$MONTH" -ge 7 ] && SEASON=$((SEASON + 1))
cd "$PROJECT"
if [ -f "artifacts/forecasts/$YESTERDAY/forecast_$YESTERDAY.json" ]; then
  .venv/bin/python -m betting.ledger grade --date "$YESTERDAY" || echo "grading $YESTERDAY failed (results not in yet?); continuing"
fi
.venv/bin/python -m betting.ledger regrade --season "$SEASON" || true
.venv/bin/python -m betting.publish_site --date "$DATE" --site-dir "$SITE_DIR"
cd "$SITE_DIR"
git status --short . | head -20
echo "review, then: git add -A personal && git commit -m 'Forecasts $DATE' && git push"
