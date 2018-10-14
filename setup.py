import versioneer
from setuptools import setup, find_packages

setup(
    name='cookiecutter-flask-react',
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    description='Cookiecutter for creating a Flask-React application',
    author='Peter Parente',
    packages=find_packages(),
    include_package_data=True,
    license='MIT'
)
