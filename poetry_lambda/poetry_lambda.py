#!/usr/bin/env python3
"""
Purpose

Shows how to implement an AWS Lambda function that handles input from direct
invocation.
"""

import logging
from typing import Dict
import arrow

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def main(event, context) -> Dict[str, str]:
    """
    Accepts an action and a number, performs the specified action on the number,
    and returns the result.

    :param event: The event dict that contains the parameters sent when the function
                  is invoked.
    :param context: The context in which the function is called.
    :return: The result of the specified action.
    """
    logger.info(f"Event: ${event}")
    logger.info(f"Context: ${context}")
    response = {"result": str(arrow.utcnow())}
    return response
