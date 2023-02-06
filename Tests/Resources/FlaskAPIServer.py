from flask import Flask, jsonify, request
from collections import defaultdict
import logging

app = Flask(__name__)
app.config["JSON_SORT_KEYS"] = False

default_person = (
    {
        "name": "Jabba Desilijic Tiure",
        "height": "175",
        "mass": "1,358",
        "hair_color": "n/a",
        "skin_color": "green-tan, brown",
        "eye_color": "orange",
        "birth_year": "600BBY",
        "gender": "hermaphrodite",
        "homeworld": "https://swapi.dev/api/planets/24/",
        "films": [
            "https://swapi.dev/api/films/1/",
            "https://swapi.dev/api/films/3/",
            "https://swapi.dev/api/films/4/",
        ],
        "species": ["https://swapi.dev/api/species/5/"],
        "vehicles": [],
        "starships": [],
        "created": "2014-12-10T17:11:31.638000Z",
        "edited": "2014-12-20T21:17:50.338000Z",
        "url": "https://swapi.dev/api/people/16/",
    },
)

default_starship = (
    {
        "name": "Death Star",
        "model": "DS-1 Orbital Battle Station",
        "manufacturer": "Imperial Department of Military Research, Sienar Fleet Systems",
        "cost_in_credits": "1000000000000",
        "length": "120000",
        "max_atmosphering_speed": "n/a",
        "crew": "342,953",
        "passengers": "843,342",
        "cargo_capacity": "1000000000000",
        "consumables": "3 years",
        "hyperdrive_rating": "4.0",
        "MGLT": "10",
        "starship_class": "Deep Space Mobile Battlestation",
        "pilots": [],
        "films": ["https://swapi.dev/api/films/1/"],
        "created": "2014-12-10T16:36:50.509000Z",
        "edited": "2014-12-20T21:26:24.783000Z",
        "url": "https://swapi.dev/api/starships/9/",
    },
)
default_planet = (
    {
        "name": "Serenno",
        "rotation_period": "unknown",
        "orbital_period": "unknown",
        "diameter": "unknown",
        "climate": "unknown",
        "gravity": "unknown",
        "terrain": "rainforests, rivers, mountains",
        "surface_water": "unknown",
        "population": "unknown",
        "residents": ["https://swapi.dev/api/people/67/"],
        "films": [],
        "created": "2014-12-20T16:52:13.357000Z",
        "edited": "2014-12-20T20:58:18.510000Z",
        "url": "https://swapi.dev/api/planets/52/",
    },
)

people = defaultdict(lambda: default_person)
# set up logging
logging.basicConfig(
    filename="server_log.log",
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


@app.route("/people/<int:id>", methods=["GET"])
def get_person(id):
    if id <= 0 or id >= 100:
        return (
            jsonify(
                {
                    "error": "Person not found with id:"
                    + str(id)
                    + ". Please try with ids less than 100"
                }
            ),
            404,
        )
    return jsonify(default_person)


@app.route("/planets/<int:id>", methods=["GET"])
def get_planet(id):
    if id <= 0 or id >= 100:
        return (
            jsonify(
                {
                    "error": "planet not found with id:"
                    + str(id)
                    + ". Please try with ids less than 100"
                }
            ),
            404,
        )
    planet = default_planet[0]
    planet["id"] = id
    return jsonify(planet)


@app.route("/starships/<int:id>", methods=["GET"])
def get_starship(id):
    if id <= 0 or id >= 100:
        return (
            jsonify(
                {
                    "error": "Starship not found with id:"
                    + str(id)
                    + ". Please try with ids less than 100"
                }
            ),
            404,
        )
    return jsonify(default_starship)


@app.route("/")
def root():
    endpoints = [
        str(rule)
        for rule in app.url_map.iter_rules()
        if str(rule).startswith(("/people", "/planets", "/starships"))
        and app.view_functions.get(rule.endpoint, None) is not None
    ]
    return jsonify({"endpoints": endpoints})


app.run(port=5008)
