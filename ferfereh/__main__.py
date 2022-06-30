import argparse
from . import *
from .publish import *
from abcli import logging
import logging

logger = logging.getLogger(__name__)

parser = argparse.ArgumentParser(name, description=f"{name}-{version}")
parser.add_argument(
    "task",
    type=str,
    help="",
)
args = parser.parse_args()

success = False
if args.task == "":
    success = True
else:
    logger.error(f"-{name}: {args.task}: command not found.")

if not success:
    logger.error(f"-{name}: {args.task}: failed.")
