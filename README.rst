.. title: OSEHRA VistA-FOIA

=================
OSEHRA VistA-FOIA
=================

This source tree holds a reference copy of M components for VistA, the
Veterans Health Information Systems and Technology Architecture.  It
is maintained by OSEHRA, the Open Source Electronic Health Record Agent.

-------
Purpose
-------

This source tree contains a static representation of VistA M
components exported for representation on the host filesystem.
VistA is built on a database platform that houses both code and data
so it requires programmatic operations to apply changes while
maintaining consistency.  See the OSEHRA `VistA Source Tree`_ for
tools to load these VistA components into a M database and for patches
that may be applied to a running VistA instance to keep it up to date.

------
Layout
------

The source tree is organized as follows:

* `<Packages.csv>`__: A spreadsheet recording VistA packages.  For each
  package it has a name, namespaces, file numbers and names, and a
  directory name for this source tree.

* ``Packages/<package>/Routines/``: Holds M routine ``.m`` sources.

* ``Packages/<package>/Globals/``: Holds M global ``.zwr`` files.
  M globals are organized into host files by FileMan file.
  Each ``.zwr`` file is either named ``<num>+<name>.zwr`` for
  FileMan file number ``<num>`` with name ``<name>`` or named
  ``<gbl>.zwr`` for a ``<gbl>`` global not holding a FileMan file.

-----
Links
-----

* OSEHRA Homepage: http://osehra.org
* OSEHRA Repositories: http://code.osehra.org
* OSEHRA Github: https://github.com/OSEHRA
* OSEHRA Gitorious: https://gitorious.org/osehra
* VA VistA Document Library: http://www.va.gov/vdl

.. _`VistA Source Tree`: http://code.osehra.org/VistA.git
