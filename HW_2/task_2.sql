/* �������� ���� ������ example, ���������� � ��� ������� users, ��������� �� ���� ��������, ��������� id � ���������� name */

-- ������� �� ���� ��� ����������
DROP DATABASE IF EXISTS example;

-- ������� �� (�������������� ������� ��������� �� ����, ��� ��� ����� ���� ������ ������������ ��)
CREATE DATABASE example;

-- ����� �� ��� ������
USE example;

-- �������� ������� users (�������������� ������� ��������� �� ����, ��� ��� ����� ���� ������ ������������ ��)
CREATE TABLE users (
	id SERIAL,
	name VARCHAR(256)
);