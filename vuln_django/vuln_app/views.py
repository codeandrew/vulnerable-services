from django.http import HttpResponse
from django.db import connection

def code_injection(request):
    code = request.GET.get('code')
    result = eval(code)
    return HttpResponse(f"Code executed! Result: {result}")

def sql_injection(request):
    query = request.GET.get('query')
    cursor = connection.cursor()
    cursor.execute(query)
    result = cursor.fetchall()
    return HttpResponse(f"Query executed! Result: {result}")
