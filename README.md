<div class="cell markdown">

# OPTIMADE Tutorial Exercises

[![Open In
Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Materials-Consortia/optimade-tutorial-exercises/blob/main/notebooks/demonstration-pymatgen-for-optimade-queries.ipynb)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Materials-Consortia/optimade-tutorial-exercises/HEAD?filepath=notebooks%2Fdemonstration-pymatgen-for-optimade-queries.ipynb)
[![GitHub
license](https://img.shields.io/github/license/Materials-Consortia/optimade-tutorial-exercises?logo=GitHub)](https://github.com/Materials-Consortia/optimade-tutorial-exercises)

</div>

<div class="cell markdown">

## Preface

This repository hosts general tutorials on the OPTIMADE specification
and particular database implementations of the API. These open-ended
exercises were initially provided to accompany the following workshops:

-   NOMAD CoE [Tutorial 6:
    OPTIMADE](https://th.fhi-berlin.mpg.de/meetings/nomad-tutorials/index.php?n=Meeting.Tutorial6),
    7-8 September 2021
-   ICTP-EAIFR [Training School: Working with Materials Databases and
    OPTIMADE](https://eaifr.ictp.it/about/news/ml-for-es-and-md/),
    November-December 2021.

This document is hosted on
[GitHub](https://github.com/Materials-Consortia/optimade-tutorial-exercises),
and all feedback or suggestions for new exercises can be provided as an
issue or pull request in that repository.

If you would like to get involved with the OPTIMADE consortium, you can
find some more details on the [OPTIMADE home
page](https://optimade.org/#get-involved).

### Contributors

-   [Matthew Evans](https://ml-evs.science), *UCLouvain*
-   [Matthew Horton](https://github.com/mkhorton), *LBNL*
-   [Evgeny Blokhin](https://github.com/blokhin), *Tilde Informatics*

</div>

<div class="cell markdown">

## Introduction

</div>

<div class="cell markdown">

The OPTIMADE specification defines a web-based JSON API that is
implemented by many [different materials
databases](https://www.optimade.org/providers-dashboard) to allow users
to query the underlying data with the same syntax and response format.
There are several tools that can access these APIs, for example, any web
browser, any programming language that can make HTTP requests, or common
command-line tools such as `curl` or `wget`.

There are also specialist tools, developed by members of the OPTIMADE
community. You may have heard about three such tools in other tutorials
and talks:

1.  [The Materials Cloud web-based OPTIMADE
    client](https://dev-tools.materialscloud.org/optimadeclient/).
2.  [The optimade.science web-based
    aggregator](https://optimade.science).
3.  [`pymatgen`'s built-in OPTIMADE
    client](https://pymatgen.org/pymatgen.ext.optimade.html?highlight=optimade#module-pymatgen.ext.optimade).

Each of these clients can send requests to multiple OPTIMADE providers
*simultaneously*, based on programmatic [providers
list](https://providers.optimade.org/). You can explore this list at the
human-readable [providers
dashboard](https://www.optimade.org/providers-dashboard/), where you can
see the current OPTIMADE structure count exceeds 17 million!

You may wish to familiarise yourselves with the OPTIMADE API by writing
your own queries, scripts or code. Some possible options:

-   Craft (or copy) your own URL queries to a particular OPTIMADE
    implementation. Some web browsers (e.g., Firefox) will automatically
    format the JSON response for you (see Exercise 1).
-   Use command-line tools such as [`curl`](https://curl.se/) or
    [`wget`](https://www.gnu.org/software/wget/) to receive data in your
    terminal, or pipe it to a file. You could use the tool
    [`jq`](https://stedolan.github.io/jq/) to format the JSON response.
-   Make an appropriate HTTP request from your programming language of
    choice. For Python, you could use the standard library
    [urllib.request](https://docs.python.org/3/library/urllib.request.html)
    or the more ergonomic external library
    [requests](https://requests.readthedocs.io/en/master/). Some example
    code for Python is provided in Exercise 1 below. In Javascript, you
    can just use `fetch(...)` or a more advanced [optimade
    client](https://github.com/tilde-lab/optimade-client).

If you are following these tutorials as part of a school or workshop,
please do not hesitate to ask about how to get started with any of the
above tools!

</div>

<div class="cell markdown">

## Exercise 1

</div>

<div class="cell markdown">

This aim of this exercise is to familiarise yourself with the OPTIMADE
JSON API. In the recent OPTIMADE paper \[[1](#ref1)\], we provided the
number of results to a set of queries across all OPTIMADE
implementations, obtained by applying the same filter to the structures
endpoint of each database. The filters are:

-   Query for structures containing a group IV element:
    `elements HAS ANY "C", "Si", "Ge", "Sn", "Pb"`.

-   As above, but return only binary phases:
    `elements HAS ANY "C", "Si", "Ge", "Sn", "Pb" AND nelements=2`.

-   This time, exclude lead and return ternary phases:
    `elements HAS ANY "C", "Si", "Ge", "Sn" AND NOT elements HAS "Pb" AND elements LENGTH 3`.

-   In your browser, try visiting the links in Table 1 of the OPTIMADE
    paper \[[1](#ref1)\] (clickable links in arXiv version
    \[[2](#ref2)\]), which is reproduced below.

    -   Familiarise yourself with the standard JSON:API output fields
        (`data`, `meta` and `links`).
    -   You will find the crystal structures returned for the query as a
        list under the `data` key, with the OPTIMADE-defined fields
        listed under the `attributes` of each list entry.
    -   The `meta` field provides useful information about your query,
        e.g. `data_returned` shows how many results there are in total,
        not just in the current page of the response (you can check if
        the table still contains the correct number of entries, or if it
        is now out of date).
    -   The `links` field provides links to the next or previous pages
        of your response, in case you requested more structures than the
        `page_limit` for that implementation.

-   Choose one particular entry to focus on: replace the `filter` URL
    parameter with `/<structure_id>` for the `id` of one particular
    structure (e.g.
    `https://example.org/optimade/v1/structures/<structure_id>`).

-   Explore other endpoints provided by each of these providers. If they
    serve "extra" fields (i.e. those containing the provider prefix),
    try to find out what these fields mean by querying the
    `/info/structures` endpoint.

-   Try performing the same queries with some of the tools listed above,
    or in scripts of your own design.

<center>
<table>
    <tr>
        <th>Provider</th>
        <th>N<sub>1</sub></th>
        <th>N<sub>2</sub></th>
        <th>N<sub>3</sub></th>
    </tr>
    <tr>
        <td><a href="http://www.aflow.org">AFLOW</a><span class="citation" data-cites="AFLOW_database aflow_fleet_chapter"></span> </td>
        <td><a href="http://aflow.org/API/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">700,192</a> </td>
        <td><a href="http://aflow.org/API/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">62,293</a></td>
        <td><a href="http://aflow.org/API/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">382,554</a></td>
    </tr>
    <tr>
        <td><a href="https://www.crystallography.net/cod">Crystallography Open Database</a> (COD)<span class="citation" data-cites="Grazulis_COD_2009 Grazulis_COD_2012"></span></td>
        <td><a href="https://www.crystallography.net/cod/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">416,314</a> </td>
        <td><a href="https://www.crystallography.net/cod/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">3,896</a> </td>
        <td><a href="https://www.crystallography.net/cod/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">32,420</a></td>
    </tr>
    <tr>
        <td><a href="https://www.crystallography.net/tcod">Theoretical Crystallography Open Database</a> (TCOD)<span class="citation" data-cites="Merkys_TCOD_2017"></span> </td>
        <td><a href="https://www.crystallography.net/tcod/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">2,631</a> </td>
        <td><a href="https://www.crystallography.net/tcod/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">296</a> </td>
        <td><a href="https://www.crystallography.net/tcod/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">660</a></td>
    </tr>
    <tr>
        <td><a href="https://materialscloud.org">Materials Cloud</a><span class="citation" data-cites="AiiDA AiiDA2 MaterialsCloud"></span> </td>
        <td><a href="https://aiida.materialscloud.org/optimade-sample/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">886,518</a> </td>
        <td><a href="https://aiida.materialscloud.org/optimade-sample/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">801,382</a> </td>
        <td><a href="https://aiida.materialscloud.org/optimade-sample/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">103,075</a></td>
    </tr>
    <tr>
        <td><a href="http://materialsproject.org">Materials Project</a><span class="citation" data-cites="Materials_Project Jain_2011 Ong_pymatgen_2013 Mathew_Atomate_CMS_2017"></span> </td>
        <td><a href="https://optimade.materialsproject.org/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">27,309</a> </td>
        <td><a href="https://optimade.materialsproject.org/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">3,545</a> </td>
        <td><a href="https://optimade.materialsproject.org/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">10,501</a></td>
    </tr>
    <tr>
        <td><a href="https://nomad-lab.eu">Novel Materials Discovery Laboratory</a> (NOMAD)<span class="citation" data-cites="NOMAD_2017 NOMAD_2018"></span> </td>
        <td><a href="https://nomad-lab.eu/prod/rae/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">3,359,594</a> </td>
        <td><a href="https://nomad-lab.eu/prod/rae/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">532,123</a> </td>
        <td><a href="https://nomad-lab.eu/prod/rae/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">1,611,302</a></td>
    </tr>
    <tr>
        <td><a href="https://odbx.science">Open Database of Xtals</a> (odbx)<span class="citation" data-cites="odbx-matador"></span> </td>
        <td><a href="https://optimade.odbx.science/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">55</a> </td>
        <td><a href="https://optimade.odbx.science/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">54</a> </td>
        <td><a href="https://optimade.odbx.science/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">0</a></td>
    </tr>
    <tr>
        <td><a href="http://openmaterialsdb.se">Open Materials Database</a> (<em>omdb</em>)<span class="citation" data-cites="HTTKOMDB"></span> </td>
        <td><a href="http://optimade.openmaterialsdb.se/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">58,718</a> </td>
        <td><a href="http://optimade.openmaterialsdb.se/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">690</a> </td>
        <td><a href="http://optimade.openmaterialsdb.se/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">7,428</a></td>
    </tr>
    <tr>
        <td><a href="http://oqmd.org">Open Quantum Materials Database</a> (OQMD)<span class="citation" data-cites="OQMD"></span> </td>
        <td><a href="http://oqmd.org/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot;">153,113</a> </td>
        <td><a href="http://oqmd.org/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot;,&quot;Pb&quot; AND nelements=2">11,011</a> </td>
        <td><a href="http://oqmd.org/optimade/v1/structures?filter=elements HAS ANY &quot;C&quot;,&quot;Si&quot;,&quot;Ge&quot;,&quot;Sn&quot; AND NOT elements HAS &quot;Pb&quot; AND elements LENGTH 3">70,252</a></td>
    </tr>
</table>
</center>

<span id="ref1">\[1\]</span> Andersen *et al.*, "OPTIMADE, an API for
exchanging materials data", *Sci Data* **8**, 217 (2021)
[10.1038/s41597-021-00974-z](https://doi.org/10.1038/s41597-021-00974-z).

<span id="ref2">\[2\]</span> Andersen *et al.*, "OPTIMADE, an API for
exchanging materials data" (2021)
[arXiv:2103.02068](https://arxiv.org/abs/2103.02068).

</div>

<div class="cell markdown">

## Exercise 2

</div>

<div class="cell markdown">

The filters from Exercise 1 screened for group IV containing compounds,
further refining the query to exclude lead, and finally to include only
ternary phases.

-   Choose a suitable database and modfiy the filters from Exercise 1 to
    search for binary \[III\]-\[V\] semiconductors.
    -   A "suitable" database here is one that you think will have good
        coverage across this chemical space.
-   Using the `chemical_formula_anonymous` field, investigate the most
    common stoichiometric ratios between the constituent elements, e.g.
    1:1, 2:1, etc.
    -   You may need to follow pagination links (`links->next` in the
        response) to access all available data for your query, or you
        can try adding the `page_limit=100` URL parameter to request
        more structures per response.
-   Apply the same filter to another database and assess the similarity
    between the results, thinking carefully about how the different
    focuses of each database and different methods in their
    construction/curation could lead to biases in this outcome.
    -   For example, an experimental database may have one crystal
        structure entry per experimental sample studied, in which case
        the most useful (or "fashionable") compositions will return many
        more entries, especially when compared to a database that
        curates crystal structures such that each ideal crystal has one
        canonical entry (e.g., a database of minerals).
-   Try to use the query you have constructed in the multi-provider
    clients (linked above), to query all OPTIMADE providers
    simultaneously.

</div>

<div class="cell markdown">

## Exercise 3

</div>

<div class="cell markdown">

This interactive exercise will explore the use of the OPTIMADE client
implemented in the `pymatgen` Python library. This exercise can be found
in this repository under `./notebooks/demonstration-pymatgen.ipynb` or
accessed online in [Google
Colab](https://colab.research.google.com/github/Materials-Consortia/optimade-tutorial-exercises/blob/main/notebooks/demonstration-pymatgen-for-optimade-queries.ipynb)
(or equivalent notebook runners, such as
[Binder](https://mybinder.org/v2/gh/Materials-Consortia/optimade-tutorial-exercises/HEAD?filepath=notebooks%2Fdemonstration-pymatgen-for-optimade-queries.ipynb)).

[![Open In
Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Materials-Consortia/optimade-tutorial-exercises/blob/main/notebooks/demonstration-pymatgen-for-optimade-queries.ipynb)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Materials-Consortia/optimade-tutorial-exercises/HEAD?filepath=notebooks%2Fdemonstration-pymatgen-for-optimade-queries.ipynb)

</div>

<div class="cell markdown">

## Exercise 4

</div>

<div class="cell markdown">

There are many useful properties that the OPTIMADE specification has not
standardized. This is typically because the use of the property requires
additional context, e.g., reporting a "band gap" without describing how
it was calculated or measured, or properties that are only meaningful in
the context of a database, e.g., relative energies that depend on other
reference calculations. For this reason, the OPTIMADE specification
allows implementations to serve their own fields with an appropriate
"provider prefix" to the field name, and a description at the
`/info/structures` endpoint.

One computed property that is key to many high-throughput studies is the
*chemical stability* (*δ*) of a crystal structure, i.e. whether the
structure is predicted to spontaneously decompose into a different phase
(or phases). This is typically computed as the distance from the convex
hull in composition-energy space, with a value of 0 (or \<0, if the
target structure was not used to compute the hull itself) indicating a
stable structure.

-   Interrogate the `/info/structures` endpoints of the OPTIMADE
    implementations that serve DFT data (e.g., Materials Project, AFLOW,
    OQMD, etc.) and identify those that serve a field that could
    correspond to hull distance, or other stability metrics.
-   Construct a filter that allows you to screen a database for
    metastable materials (i.e., 0 \< *δ* \< 25 meV/atom) according to
    this metric.
-   Try to create a filter that can be applied to multiple databases
    simultaneously (e.g., apply
    `?filter=_databaseA_hull_distance < 25 OR _databaseB_stability < 25`).
    What happens when you run this filter against a database that does
    not contain the field?

</div>

<div class="cell markdown">

## Exercise 5

</div>

<div class="cell markdown">

As a final exercise, consider your own research problems and how you
might use OPTIMADE. If you have any suggestions or feedback about how
OPTIMADE can be made more useful for you, please start a discussion on
the [OPTIMADE MatSci forum](https://matsci.org/c/optimade/29) or raise
an issue at the appropriate [Materials-Consortia
GitHub](https://github.com/Materials-Consortia/) repository.

Some potential prompts:

-   What additional fields or entry types should OPTIMADE standardize to
    be most useful to you?
-   How could the existing tools be improved, or what new tools could be
    created to make OPTIMADE easier to use?
-   What features from other APIs/databases that you use could be
    adopted within OPTIMADE?

</div>

<div class="cell markdown">

## Example Python code

You may find the following Python code snippets useful in the above
exercises. This document can be opened as a Jupyter notebook using the
Colab or Binder buttons above, or by downloading the notebook from the
GitHub repository.

</div>

<div class="cell code" execution_count="72">

``` python
# Construct a query URL
# You should be able to use any valid OPTIMADE implementation's database URL with any valid query


# Lets choose a random provider for now:
import random
some_optimade_base_urls = ["https://optimade.materialsproject.org", "http://crystallography.net/cod/optimade", "https://nomad-lab.eu/prod/rae/optimade/"]
database_url = random.choice(some_optimade_base_urls)

query = 'elements HAS ANY "C", "Si", "Ge", "Sn", "Pb"'
other_options = "page_limit=3"

query_url = f"{database_url}/v1/structures?filter={query}&{other_options}"
```

</div>

<div class="cell code" execution_count="73">

``` python
# Using the third-party requests library:
!pip install requests
```

<div class="output stream stdout">

    Requirement already satisfied: requests in /usr/lib/python3/dist-packages (2.22.0)

</div>

</div>

<div class="cell code" execution_count="74">

``` python
# Import the requests library and make the query
import requests
response = requests.get(query_url)
print(response)
json_response = response.json()
```

<div class="output stream stdout">

    <Response [200]>

</div>

</div>

<div class="cell code" execution_count="83">

``` python
# Explore the results
import pprint
print(json_response.keys())
structures = json_response["data"]
meta = json_response["meta"]

print(f"Query {query_url} returned {meta['data_returned']} structures")

print("First structure:")
pprint.pprint(structures[0])
```

<div class="output stream stdout">

    dict_keys(['data', 'links', 'meta'])
    Query http://crystallography.net/cod/optimade/v1/structures?filter=elements HAS ANY "C", "Si", "Ge", "Sn", "Pb"&page_limit=3 returned 428712 structures
    First structure:
    {'attributes': {'_cod_Rall': 0.1073,
                    '_cod_Robs': 0.0584,
                    '_cod_Z': '4',
                    '_cod_Zprime': 1,
                    '_cod_a': 7.8783,
                    '_cod_acce_code': 'GS1096',
                    '_cod_alpha': 90,
                    '_cod_authors': 'Phan Thanh, S.; Marrot, J.; Renaudin, J.; '
                                    'Maisonneuve, V.',
                    '_cod_b': 10.4689,
                    '_cod_beta': 95.147,
                    '_cod_c': 16.068,
                    '_cod_calcformula': '- C5 H17 Al N2 O8 P2 -',
                    '_cod_cellformula': '- C20 H68 Al4 N8 O32 P8 -',
                    '_cod_celltemp': 296,
                    '_cod_date': '2020-10-21',
                    '_cod_diffrtemp': 296,
                    '_cod_doi': '10.1107/S0108270100008532',
                    '_cod_duplicateof': '2011331',
                    '_cod_file': '1000000',
                    '_cod_firstpage': '1073',
                    '_cod_flags': 'has coordinates',
                    '_cod_formula': '- C5 H17 Al N2 O8 P2 -',
                    '_cod_gamma': 90,
                    '_cod_gofall': 1.055,
                    '_cod_gofref': 1.08,
                    '_cod_issue': '9',
                    '_cod_journal': 'Acta Crystallographica, Section C',
                    '_cod_lastpage': '1074',
                    '_cod_nel': '6',
                    '_cod_radType': 'MoKα',
                    '_cod_sg': 'P 1 21/n 1',
                    '_cod_sgHall': '-P 2yn',
                    '_cod_siga': 0.0002,
                    '_cod_sigb': 0.0001,
                    '_cod_sigbeta': 0.001,
                    '_cod_sigc': 0.0004,
                    '_cod_sigcelltemp': 2,
                    '_cod_sigdiffrtemp': 2,
                    '_cod_sigvol': 0.05,
                    '_cod_svnrevision': '176729',
                    '_cod_text': 'Phan Thanh, S.; Marrot, J.; Renaudin, J.; '
                                 'Maisonneuve, V.\n'
                                 '[H~3~N(CH~2~)~5~NH~3~].AlP~2~O~8~H, a '
                                 'one-dimensional aluminophosphate\n'
                                 'Acta Crystallographica, Section C\n'
                                 '56(9)\n'
                                 '(2000)\n'
                                 '1073-1074',
                    '_cod_time': '18:00:00',
                    '_cod_title': '[H~3~N(CH~2~)~5~NH~3~].AlP~2~O~8~H, a '
                                  'one-dimensional aluminophosphate',
                    '_cod_vol': 1319.9,
                    '_cod_volume': '56',
                    '_cod_wRall': 0.2069,
                    '_cod_wRref': 0.1362,
                    '_cod_wavelength': 0.71073,
                    '_cod_year': '2000',
                    'chemical_formula_descriptive': 'C5H17AlN2O8P2',
                    'chemical_formula_hill': 'C5H17AlN2O8P2',
                    'dimension_types': [1, 1, 1],
                    'elements': ['Al', 'C', 'H', 'N', 'O', 'P'],
                    'elements_ratios': [0.0285714285714286,
                                        0.142857142857143,
                                        0.485714285714286,
                                        0.0571428571428571,
                                        0.228571428571429,
                                        0.0571428571428571],
                    'last_modified': '2020-10-21T18:00:00Z',
                    'lattice_vectors': [[7.8783, 0, 0],
                                        [0, 10.4689, 0],
                                        [-1.44148155534836, 0, 16.0032107692672]],
                    'nelements': 6,
                    'nperiodic_dimensions': 3},
     'id': '1000000',
     'links': {'self': 'https://www.crystallography.net/cod/optimade/v1.0.0/structures/1000000'},
     'relationships': {'references': {'data': [{'id': '1000000',
                                                'type': 'references'}]}},
     'type': 'structures'}

</div>

</div>
