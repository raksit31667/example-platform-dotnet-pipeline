import pytest
import subprocess

@pytest.fixture(autouse=True)
def setup_and_teardown():
    # Setup

    yield

    # Teardown
    subprocess.call(['docker', 'image', 'prune', '-af'])

def test_build_docker_base_images_step_given_docker_registry_name_should_build_base_application_docker_image():
    registry = 'exampleplatformacr.azurecr.io'
    exit_code = subprocess.call(['./platform/steps/build_docker_base_images.sh', registry])

    assert exit_code == 0
    docker_images_output = subprocess.check_output(['docker', 'images', '-q', 'exampleplatformacr.azurecr.io/base-application'])
    assert docker_images_output.decode()

def test_build_docker_base_images_step_given_docker_registry_name_should_build_base_dotnet_command_docker_image():
    registry = 'anotherexampleplatformacr.azurecr.io'
    exit_code = subprocess.call(['./platform/steps/build_docker_base_images.sh', registry])

    assert exit_code == 0
    docker_images_output = subprocess.check_output(['docker', 'images', '-q', 'anotherexampleplatformacr.azurecr.io/base-dotnet-command'])
    assert docker_images_output.decode()

def test_build_docker_base_images_step_given_docker_registry_name_should_build_http_stub_server_docker_image():
    registry = 'exampleplatformacr.azurecr.io'
    exit_code = subprocess.call(['./platform/steps/build_docker_base_images.sh', registry])

    assert exit_code == 0
    docker_images_output = subprocess.check_output(['docker', 'images', '-q', 'exampleplatformacr.azurecr.io/http-stub-server'])
    assert docker_images_output.decode()

def test_build_docker_base_images_step_given_docker_registry_name_should_build_http_stub_server_proxy_docker_image():
    registry = 'exampleplatformacr.azurecr.io'
    exit_code = subprocess.call(['./platform/steps/build_docker_base_images.sh', registry])

    assert exit_code == 0
    docker_images_output = subprocess.check_output(['docker', 'images', '-q', 'exampleplatformacr.azurecr.io/http-stub-server-proxy'])
    assert docker_images_output.decode()

def test_build_docker_base_images_step_given_no_docker_registry_name_should_exit_with_status_code_1():
    exit_code = subprocess.call(['./platform/steps/build_docker_base_images.sh'])

    assert exit_code == 1
