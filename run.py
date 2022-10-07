import click

from loguru import logger

import bizness.performer


@click.group()
def cli():
    pass


@cli.command()
def perform():
    performance = bizness.performer.perform_something()
    logger.info(f"Performance output: {performance}")


if __name__ == "__main__":
    cli()
