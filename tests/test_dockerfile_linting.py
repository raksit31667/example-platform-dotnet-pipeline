import os
import pytest
import subprocess

@pytest.fixture(autouse=True)
def setup_and_teardown():
    # Setup

    yield

    # Teardown
    subprocess.call(['docker', 'image', 'prune', '-af'])

def test_dockerfile_linting_given_passing_project_should_exit_with_status_code_0():
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/fixtures/dockerfile/passing'

    exit_code = subprocess.call(['./platform/steps/dockerfile_linting.sh', project_directory])

    assert exit_code == 0

def test_dockerfile_linting_given_failing_project_should_exit_with_status_code_1():
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/fixtures/dockerfile/failing'

    exit_code = subprocess.call(['./platform/steps/dockerfile_linting.sh', project_directory])

    assert exit_code == 1
