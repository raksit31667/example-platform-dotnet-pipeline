import pytest
import subprocess

@pytest.fixture(autouse=True)
def setup_and_teardown():
    # Setup

    yield

    # Teardown
    subprocess.call(['docker', 'image', 'prune', '-af'])

def test_build_docker_base_images_step_given_docker_registry_name_should_build_docker_image():
    registry = 'exampleplatformacr.azurecr.io'
    exit_code = subprocess.call(['./platform/steps/build_docker_base_images.sh', registry])

    docker_images_output = subprocess.check_output(['docker', 'images', '--format', '"{{ json .Repository }}"'])
    assert exit_code == 0
    assert 'exampleplatformacr.azurecr.io/base-application' in docker_images_output.decode('utf-8')

def test_build_docker_base_images_step_given_another_docker_registry_name_should_build_docker_image():
    registry = 'anotherexampleplatformacr.azurecr.io'
    exit_code = subprocess.call(['./platform/steps/build_docker_base_images.sh', registry])

    docker_images_output = subprocess.check_output(['docker', 'images', '--format', '"{{ json .Repository }}"'])
    assert exit_code == 0
    assert 'anotherexampleplatformacr.azurecr.io/base-application' in docker_images_output.decode('utf-8')

def test_build_docker_base_images_step_given_no_docker_registry_name_should_exit_with_status_code_1():
    exit_code = subprocess.call(['./platform/steps/build_docker_base_images.sh'])

    assert exit_code == 1
