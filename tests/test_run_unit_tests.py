import os
import pytest
import subprocess

@pytest.fixture(autouse=True)
def setup_and_teardown():
    # Setup
    registry = 'exampleplatformacr.azurecr.io'
    subprocess.call(['./platform/steps/build_docker_base_images.sh', registry])

    yield

    # Teardown
    subprocess.call(['docker', 'image', 'prune', '-af'])

def test_run_unit_tests_step_given_unit_test_project_with_passing_tests_with_coverlet_should_run_successfully():
    registry = 'exampleplatformacr.azurecr.io'
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/fixtures/dotnet/unit-tests/passing'
    unit_test_project = 'Consumer.UnitTests'

    exit_code = subprocess.call(['./consumer/steps/run_unit_tests.sh', registry, project_directory, unit_test_project])

    assert exit_code == 0

def test_run_unit_tests_step_given_unit_test_project_with_passing_tests_without_coverlet_should_run_successfully():
    registry = 'exampleplatformacr.azurecr.io'
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/fixtures/dotnet/unit-tests/no-coverlet'
    unit_test_project = 'Consumer.UnitTests'

    exit_code = subprocess.call(['./consumer/steps/run_unit_tests.sh', registry, project_directory, unit_test_project])

    assert exit_code == 0

def test_run_unit_tests_step_given_unit_test_project_with_passing_tests_without_coverlet_should_fail():
    registry = 'exampleplatformacr.azurecr.io'
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/fixtures/dotnet/unit-tests/failing'
    unit_test_project = 'Consumer.UnitTests'

    exit_code = subprocess.call(['./consumer/steps/run_unit_tests.sh', registry, project_directory, unit_test_project])

    assert exit_code == 1
