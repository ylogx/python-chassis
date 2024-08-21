import os

from loguru import logger


def perform_something():
    logger.debug("Performing something")

    env_flags = os.environ
    noise = value_generator(add_noise=True)
    logger.info(f"My environment has {len(env_flags)} variables and noise is {noise}.")

    return ["Everything everywhere all at once."]


def value_generator(add_noise: bool = False) -> float:
    import random

    noise = random.random() if add_noise else 0.0
    logger.debug(f"Current noise value: {noise}")
    return 42.0 + noise
