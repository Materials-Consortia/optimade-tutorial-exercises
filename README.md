<div class="cell markdown">

# OPTIMADE NOMAD CoE Tutorial Exercises

</div>

<div class="cell markdown">

## Introduction

</div>

<div class="cell markdown">

These open-ended exercises are provided to accompany NOMAD CoE [Tutorial
6:
OPTIMADE](https://th.fhi-berlin.mpg.de/meetings/nomad-tutorials/index.php?n=Meeting.Tutorial6),
run across the 7th and 8th of September 2021.

The OPTIMADE specification defines a JSON API that can be accessed with
many different tools. You will have heard about three such tools in the
tutorial:

1.  [The Materials Cloud web-based OPTIMADE
    client](https://dev-tools.materialscloud.org/optimadeclient/).
2.  [The optimade.science web-based
    aggregator](https://optimade.science).
3.  [`pymatgen`'s built-in OPTIMADE
    client](https://pymatgen.org/pymatgen.ext.optimade.html?highlight=optimade#module-pymatgen.ext.optimade).

Each of these clients can send requests to multiple OPTIMADE providers
*simultaneously*, based on the provider list at
<https://providers.optimade.org/>.

You may also wish to familiarise yourselves with the OPTIMADE API by
writing your own queries, scripts or code. Some possible options:

-   Craft (or copy) your own URL queries to a particular OPTIMADE
    implementation. Some web browsers (e.g. Firefox) will automatically
    format the JSON response for you (see Exercise 1).
-   Use command-line tools such as [`curl`](https://curl.se/) or
    [`wget`](https://www.gnu.org/software/wget/) to receive data in your
    terminal, or pipe it to a file. You could use the tool
    [`jq`](https://stedolan.github.io/jq/) to format the JSON response.
-   Make an appropriate HTTP request from your programming language of
    choice. For Python, you could use the standard library
    [urllib.request](https://docs.python.org/3/library/urllib.request.html)
    or the more ergonomic external library
    [requests](https://requests.readthedocs.io/en/master/). In
    Javascript, you can just use `fetch(...)`.

</div>

<div class="cell markdown">

## Exercise 1

For example, you could try visiting the links in Table 1 of the OPTIMADE
paper \[1\] (clickable links in arXiv version \[2\]), which is
reproduced below.

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

\[1\] Andersen *et al.*, "OPTIMADE, an API for exchanging materials
data", *Sci Data* **8**, 217 (2021)
[10.1038/s41597-021-00974-z](https://doi.org/10.1038/s41597-021-00974-z).  
\[2\] Andersen *et al.*, "OPTIMADE, an API for exchanging materials
data", [arXiv:2103.02068](https://arxiv.org/abs/2103.02068) (2021).

</div>

<div class="cell markdown">

## Exercise 2

</div>

<div class="cell code">

``` python
```

</div>
