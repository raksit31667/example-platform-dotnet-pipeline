import os
import pytest
import subprocess

@pytest.fixture(autouse=True)
def setup_and_teardown():
    # Setup

    yield

    # Teardown
    subprocess.call(['docker', 'image', 'prune', '-af'])

def test_shell_linting_given_passing_project_should_exit_with_status_code_0():
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/shell_linting/passing'

    exit_code = subprocess.call(['./platform/steps/shell_linting.sh', project_directory])

    assert exit_code == 0

def test_shell_linting_given_failing_project_should_exit_with_status_code_1():
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/shell_linting/failing'

    exit_code = subprocess.call(['./platform/steps/shell_linting.sh', project_directory])

    assert exit_code == 1
