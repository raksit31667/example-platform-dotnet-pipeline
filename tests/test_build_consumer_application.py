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

def test_build_consumer_application_step_given_mandatory_arguments_should_build_dotnet_application():
    registry = 'exampleplatformacr.azurecr.io'
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/fixtures/dotnet/project'
    package_name = 'Consumer.WebApi'
    build_number = '1.2.3'

    exit_code = subprocess.call(['./consumer/steps/build_consumer_application.sh', registry, project_directory, package_name, build_number])

    assert exit_code == 0

def test_build_consumer_application_step_given_mandatory_arguments_without_build_number_should_build_dotnet_application_with_zero_version():
    registry = 'exampleplatformacr.azurecr.io'
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/fixtures/dotnet/project'
    package_name = 'Consumer.WebApi'

    exit_code = subprocess.call(['./consumer/steps/build_consumer_application.sh', registry, project_directory, package_name])

    assert exit_code == 0

def test_build_consumer_application_step_given_no_docker_registry_name_should_exit_with_status_code_1():
    exit_code = subprocess.call(['./consumer/steps/build_consumer_application.sh'])

    assert exit_code == 1

def test_build_consumer_application_step_given_no_project_directory_should_exit_with_status_code_1():
    registry = 'exampleplatformacr.azurecr.io'

    exit_code = subprocess.call(['./consumer/steps/build_consumer_application.sh', registry])

    assert exit_code == 1

def test_build_consumer_application_step_given_no_package_name_should_exit_with_status_code_1():
    registry = 'exampleplatformacr.azurecr.io'
    current_directory = os.getcwd()
    project_directory = f'{current_directory}/tests/fixtures/dotnet/project'

    exit_code = subprocess.call(['./consumer/steps/build_consumer_application.sh', registry, project_directory])

    assert exit_code == 1
