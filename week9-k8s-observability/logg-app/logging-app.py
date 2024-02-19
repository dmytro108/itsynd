#!/usr/bin/env python3
import logging
import time
import random
import sys

# Define the log levels
LOG_LEVELS = [logging.DEBUG, logging.INFO,
              logging.WARNING, logging.ERROR, logging.CRITICAL]
# Define the log messages for each log level
LOGGER_MESSAGES = {
    logging.DEBUG: 'debug',
    logging.INFO: 'info',
    logging.WARNING: 'warning',
    logging.ERROR: 'error',
    logging.CRITICAL: 'critical'
}

# Define the log file format
FORMATTER = logging.Formatter('%(levelname)s:%(asctime)s:%(message)s:%(module)s:%(filename)s',
                              datefmt='%d/%m/%Y %H:%M:%S')
SLEEP_TIME = 2  # 2 seconds


def get_logger():
    """
    Returns a logger object with the specified configuration.
    The logger will log to both the console and a rotating log file.
    """
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.DEBUG)

    # Create handlers
    # stream_handler = logging.StreamHandler(sys.stdout)
    stream_handler = logging.StreamHandler(sys.stderr)

    # Set formatter for the handlers
    stream_handler.setFormatter(FORMATTER)

    # Add the handlers to the logger
    logger.addHandler(stream_handler)

    return logger


def log_random_message(logger):
    """
    Logs a random message.
    """
    log_level = random.choice(LOG_LEVELS)
    logger.log(log_level, f"This is a {LOGGER_MESSAGES[log_level]} message")


def main():
    """
    This function initializes the logger, and logs a random message at regular intervals.
    """
    logger = get_logger()

    while True:
        log_random_message(logger)
        time.sleep(SLEEP_TIME)


if __name__ == "__main__":
    main()
