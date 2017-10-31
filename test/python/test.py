import cx_Oracle

def test_current_user_access():
    connection = cx_Oracle.connect('/')
    cursor = connection.cursor()
    cursor.execute('SELECT 1 FROM DUAL')
    assert cursor.fetchall() == [(1,)]
