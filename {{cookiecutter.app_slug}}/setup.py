import versioneer
from setuptools import setup, find_packages

setup(
    name='{{ cookiecutter.app_slug }}',
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    description='{{ cookiecutter.app_description }}',
    author='{{ cookiecutter.app_author }}',
    packages=find_packages(),
    include_package_data=True,
    license='{{ cookiecutter.app_license }}'
)
