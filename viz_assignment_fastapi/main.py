from fastapi import FastAPI, Request
import json

app = FastAPI()


@app.get("/employee")
def all_employee(request: Request):

    f = open('all_employee_data.json')
    data = json.load(f)

    sortBy = request.query_params.get("sortBy")
    order = request.query_params.get("order")
    asc = not order == "desc" 
    if(sortBy is not None):
        print(sortBy)
        data.sort(reverse = asc, key = lambda x : x.get(sortBy)) 

    country = request.query_params.get("country")
    name = request.query_params.get("name")

    if(country is not None):
        data = list(filter(lambda x : x.get("country") == country, data))
    
    if(name is not None):
        data = list(filter(lambda x : x.get("name") == name, data) )

    pageNumber = request.query_params.get("page")
    pageLimit = request.query_params.get("limit")
    if(pageNumber is not None and pageLimit is not None):

        pageNumber = int(pageNumber) 
        pageLimit = int(pageLimit)
        pageNumber = pageNumber -1
        start = pageNumber*pageLimit
        end = min(start + pageLimit, len(data)) 
        data = data[start : end]
    f.close()
    return data

@app.get("/employee/{id}")
def specific_employee(request: Request, id : str):

    f = open('all_employee_data.json')
    data = json.load(f)
    output_dict = [x for x in data if x['id'] == id]
    f.close()
    return output_dict

@app.get("/employee/{employee_id}/checkin")
def employee_checkin(request: Request, employee_id : str):

    f = open('employee_checkin_data.json')
    data = json.load(f)
    f.close()
    return data

@app.get("/employee/{employee_id}/checkin/{checkin_id}")
def specific_employee_checkin(request: Request, employee_id : str, checkin_id: str):

    f = open('employee_checkin_data.json')
    data = json.load(f)
    output_dict = [x for x in data if x['id'] == checkin_id and x['employeeId'] == employee_id]
    f.close()
    return output_dict

