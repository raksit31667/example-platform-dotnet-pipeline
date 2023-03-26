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

def test_build_docker_consumer_image_step_given_mandatory_arguments_should_build_docker_image_with_build_number_tag():
    registry = 'exampleplatformacr.azurecr.io'
    repository = 'consumer'
    dll_file_name = 'Consumer.dll'
    build_directory = 'tests/fixtures'
    build_number = '0.0.0'
    docker_image_tag = f'{registry}/{repository}:{build_number}'

    exit_code = subprocess.call(['./consumer/steps/build_docker_consumer_image.sh', registry, repository, dll_file_name, build_directory, build_number])

    docker_images_output = subprocess.check_output(['docker', 'images', '-q', docker_image_tag])
    assert exit_code == 0
    assert docker_images_output.decode()

def test_build_docker_consumer_image_step_given_no_build_number_should_build_docker_image_with_latest_tag():
    registry = 'exampleplatformacr.azurecr.io'
    repository = 'consumer'
    dll_file_name = 'Consumer.dll'
    build_directory = 'tests/fixtures'
    docker_image_tag = f'{registry}/{repository}:latest'

    exit_code = subprocess.call(['./consumer/steps/build_docker_consumer_image.sh', registry, repository, dll_file_name, build_directory])

    docker_images_output = subprocess.check_output(['docker', 'images', '-q', docker_image_tag])
    assert exit_code == 0
    assert docker_images_output.decode()

def test_build_docker_consumer_image_step_given_no_docker_registry_name_should_exit_with_status_code_1():
    exit_code = subprocess.call(['./consumer/steps/build_docker_consumer_image.sh'])

    assert exit_code == 1

def test_build_docker_consumer_image_step_given_no_docker_repository_name_should_exit_with_status_code_1():
    registry = 'exampleplatformacr.azurecr.io'

    exit_code = subprocess.call(['./consumer/steps/build_docker_consumer_image.sh', registry])

    assert exit_code == 1

def test_build_docker_consumer_image_step_given_no_dll_file_name_should_exit_with_status_code_1():
    registry = 'exampleplatformacr.azurecr.io'
    repository = 'consumer'

    exit_code = subprocess.call(['./consumer/steps/build_docker_consumer_image.sh', registry, repository])

    assert exit_code == 1

def test_build_docker_consumer_image_step_given_no_dll_file_name_should_exit_with_status_code_1():
    registry = 'exampleplatformacr.azurecr.io'
    repository = 'consumer'

    exit_code = subprocess.call(['./consumer/steps/build_docker_consumer_image.sh', registry, repository])

    assert exit_code == 1

def test_build_docker_consumer_image_step_given_no_build_directory_should_exit_with_status_code_1():
    registry = 'exampleplatformacr.azurecr.io'
    repository = 'consumer'
    dll_file_name = 'Consumer.dll'

    exit_code = subprocess.call(['./consumer/steps/build_docker_consumer_image.sh', registry, repository, dll_file_name])

    assert exit_code == 1
