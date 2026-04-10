using JSON
data=JSON.parsefile("Nordic_system.json")
unique_types = unique([d["type_tyndp"] for arr in values(data) for d in arr])

other_renewables=Dict(k => v for (k, v) in data if v[1]["type_tyndp"] == "Other RES")