import os

from loguru import logger


def perform_something():
    logger.debug("Performing something")

    env_flags = os.environ
    logger.info(f"My environment: {env_flags}")

    return ["Everything everywhere all at once."]
