# Sustainable Energy Economics (Course 32961)

Course material for Chapter 2 "Markets for Electricity" of the study text *Sustainable Energy Economics: Energy Markets and Market Transformation* (Course 32961).

This repository contains the files you need for the modelling tasks in Section 2.4. They all use the same data as the study text.

| File | What it does | Program |
|---|---|---|
| `Merit_Order_Notebook.ipynb` | Draws the merit order and lets you change demand, renewable feed-in and the carbon price with sliders. No solver needed. Used throughout Sections 2.4.1 to 2.4.3 | Visual Studio Code with Jupyter |
| `BasicModel.gms` | The base model. It writes the short-term dispatch problem as a linear program, finds the cost-minimal dispatch and gives you the market price as the dual value of the load-serving constraint. Used in Section 2.4.1 | GAMS Studio |

> **About the notebook:** The notebook is published **without saved results**.
> All outputs were removed with "Clear All Outputs" before publication, so
> nothing in it has been pre-computed. Every table and every figure appears only
> once you run the cells yourself. If you open the file and see nothing but text
> and code at first, that is not a fault, it is how the file is delivered.

---

## Table of contents

1. [Download the repository](#1-download-the-repository)
2. [What you need to install](#2-what-you-need-to-install)
3. [Part A: Jupyter notebook](#part-a-jupyter-notebook)
   - [A.1 Install Python](#a1-install-python)
   - [A.2 Install Visual Studio Code](#a2-install-visual-studio-code)
   - [A.3 Install the Python and Jupyter extensions](#a3-install-the-python-and-jupyter-extensions)
   - [A.4 Install the required packages](#a4-install-the-required-packages)
   - [A.5 Open the notebook, choose a kernel, run it](#a5-open-the-notebook-choose-a-kernel-run-it)
   - [A.6 If a package is missing](#a6-if-a-package-is-missing)
   - [A.7 Other common problems](#a7-other-common-problems)
4. [Part B: GAMS](#part-b-gams)
   - [B.1 Install GAMS](#b1-install-gams)
   - [B.2 Set up your licence](#b2-set-up-your-licence)
   - [B.3 Set HiGHS as the default solver (important)](#b3-set-highs-as-the-default-solver-important)
   - [B.4 Open and run the model](#b4-open-and-run-the-model)
   - [B.5 Looking at the results: log, listing, GDX and Excel](#b5-looking-at-the-results-log-listing-gdx-and-excel)
   - [B.6 The two extended models](#b6-the-two-extended-models)
   - [B.7 Common GAMS error messages](#b7-common-gams-error-messages)
5. [Which file to use when](#5-which-file-to-use-when)

## 1. Download the repository

You do not need to know Git. There are two ways:

**Way 1 (recommended, no extra software):**
On the front page of the repository, click the green **Code** button, then
**Download ZIP**. Unpack the archive, for example into `Documents\SusEE`.

**Way 2 (with Git):**

```bash
git clone https://github.com/fuh-energy/SusEE.git
```

A hint on where to put the folder: keep it **local**, not inside a synchronised
cloud folder (OneDrive, Dropbox, iCloud). GAMS writes several temporary files
while it runs, and the sync client can lock them. Also avoid very long paths and
special characters in the folder name.

## 2. What you need to install

| For | Software | Cost | Time needed |
|---|---|---|---|
| `Merit_Order_Notebook.ipynb` | Python 3.12, Visual Studio Code, the "Python" and "Jupyter" extensions, four Python packages | free | 20 to 30 minutes |
| The GAMS models | GAMS including GAMS Studio, plus a free licence | free for study and teaching | 20 to 30 minutes |

The two parts are independent of each other. You can start with the notebook and
set up GAMS later, or the other way round.

# Part A: Jupyter notebook

The notebook runs without GAMS and without a solver. You do not need any
previous experience with Python. You simply run the cells in the order in which
they appear.

## A.1 Install Python

The notebook was **written and tested with Python 3.12.3**. Please use a version
from the **3.12** series.

1. Open **<https://www.python.org/downloads/>**, go to the section
   "Looking for a specific release?" and choose a **3.12.x** version.
2. **Windows:** Download the "Windows installer (64-bit)". In the first dialogue,
   tick the box **"Add python.exe to PATH"** before you click "Install Now".
   Without this box, VS Code often does not find your installation later.
3. **macOS:** Download the "macOS 64-bit universal2 installer" and follow the
   installer. (The Python that ships with macOS is not suitable here.)
4. **Linux:** Use your distribution's package manager, on Ubuntu for example
   `sudo apt install python3.12 python3.12-venv`.

If Python is already installed on your computer, check the version in the command
prompt or terminal:

```bash
# Windows
py --version

# macOS and Linux
python3 --version
```

The output should start with `Python 3.12.`.

## A.2 Install Visual Studio Code

1. Open **<https://code.visualstudio.com/download>**
2. Choose the package for your operating system and install it with the default
   settings. On Windows it is useful to tick the "Open with Code" option for
   folders.

VS Code is an editor that can display and run Jupyter notebooks directly. You do
not need a separate Jupyter server in the browser.

## A.3 Install the Python and Jupyter extensions

Both extensions come from Microsoft and are free.

1. Start VS Code.
2. Open the **Extensions** sidebar: the icon with the four squares on the left,
   or the keyboard shortcut `Ctrl + Shift + X` (macOS: `Cmd + Shift + X`).
3. Search for **`Python`**. Choose the entry **Python** by *Microsoft* and click
   **Install**. The "Pylance" extension is installed with it.
4. Then search for **`Jupyter`**. Choose the entry **Jupyter** by *Microsoft* and
   click **Install** as well. Several related extensions are installed with it,
   among them the ones for cell output and the interactive sliders.
5. Restart VS Code once.

Check: under *Extensions > Installed* you should now see both "Python" and
"Jupyter".

## A.4 Install the required packages

The notebook needs four packages:

| Package | What it is used for |
|---|---|
| `pandas` | Tables (the plant fleet, the merit-order tables, the price tables) |
| `numpy` | Numerical calculations |
| `matplotlib` | All figures |
| `ipywidgets` | The interactive sliders for demand, wind, PV and the carbon price |

First open the course folder in VS Code: **File > Open Folder**, then select the
unpacked repository folder. Then open a terminal inside VS Code:
**Terminal > New Terminal**.

**Recommended way, with a virtual environment.** A virtual environment keeps the
packages of this course separate from the rest of your Python installation. It
saves you from version conflicts later.

```bash
# Windows
py -3.12 -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip
pip install pandas numpy matplotlib ipywidgets

# macOS and Linux
python3.12 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install pandas numpy matplotlib ipywidgets
```

If the repository contains a file `requirements.txt`, the last line can be
replaced by:

```bash
pip install -r requirements.txt
```

**Simple way, without a virtual environment.** If you would rather not separate
the packages:

```bash
# Windows
py -m pip install pandas numpy matplotlib ipywidgets

# macOS and Linux
python3 -m pip install pandas numpy matplotlib ipywidgets
```

## A.5 Open the notebook, choose a kernel, run it

1. Click **`Merit_Order_Notebook.ipynb`** in the file list on the left.
2. **Choose a kernel:** at the top right of the notebook there is a
   **"Select Kernel"** button. Click it, choose *Python Environments* and then
   your environment: the entry containing `.venv` if you created a virtual
   environment, otherwise your **Python 3.12.x** installation. Without a kernel
   you cannot run any cell. If VS Code asks whether to install the recommended
   extensions when you first open the file, say yes.
3. **Run:** a single cell with `Shift + Enter`. All cells one after another with
   the **Run All** button in the toolbar above the notebook.
4. **Keep the order:** the cells build on each other. Section 1 ("Setup") always
   has to run first, because it defines the functions and prepares the sliders.
   If you start in the middle, you will get `NameError` messages.

**A reminder:** the notebook deliberately contains **no saved results**. All
tables and figures come from your own runs. If you want to tidy up along the way,
use **Clear All Outputs** in the notebook toolbar. That returns the file to its
delivered state without losing any content.

If everything works, Section 5 shows the step-shaped supply curve with a dashed
demand line, and above it sliders for **demand** and **carbon price**.

## A.6 If a package is missing

The typical message is:

```
ModuleNotFoundError: No module named 'pandas'
```

Instead of `pandas` it may say `numpy`, `matplotlib` or `ipywidgets`. The cause
is always the same: the package is missing in exactly the Python environment
that is selected as the kernel. There are three ways to fix it, from the quickest
to the most reliable:

**Way 1: the suggestion from VS Code.** In many cases VS Code shows an
**"Install"** button or an "Install packages" hint directly below the error
message. One click is enough.

**Way 2: install from inside the notebook.** Add a new cell at the very top and
run it:

```python
%pip install pandas numpy matplotlib ipywidgets
```

The prefix `%pip` (not `!pip`) makes sure the packages go into **the environment
your kernel is actually using**. Then restart the kernel (**Restart** button) and
run the cells again.

**Way 3: through the terminal.** Open the terminal in VS Code, activate the
virtual environment if you use one (see A.4) and run the `pip install` command
from A.4. Then restart the kernel in the notebook.

**If the error stays after installing**, you have almost certainly selected the
wrong kernel: you installed into environment A, but the notebook runs in
environment B. Check with a cell:

```python
import sys
print(sys.executable)
print(sys.version)
```

The path in the output has to belong to the environment you installed into (so it
should contain `.venv` if you use a virtual environment). If it does not, pick the
right environment through **Select Kernel** at the top right.

**Special case `ipywidgets`.** The notebook is built so that it also runs
completely **without** this package. If it is missing, you get a note that the
interactive sliders are not available, and the example from the study text is
calculated instead. All tables and figures are still produced. You only lose the
option to vary the values interactively.

## A.7 Other common problems

| Symptom | Cause | What to do |
|---|---|---|
| "Select Kernel" shows no Python environment | Python is not installed, or not on the search path | Install Python as in A.1, on Windows with the box "Add python.exe to PATH" ticked; then restart VS Code |
| The sliders show up as an empty box or as the text `interactive(children=...)` | The Jupyter extension or its widget support is not active | Install the "Jupyter" extension as in A.3, restart VS Code, restart the kernel |
| `NameError: name 'TECH' is not defined` (or `merit_order`, `CO2_BASE`) | The cells were not run in order | Use **Run All** starting from Section 1 |
| Figures do not appear | The kernel was restarted in between | Run **Run All** again |
| A cell stays at `[*]` | The kernel is still working, or it has hung | Wait; if needed use **Interrupt**, then **Restart** and **Run All** |
| `pip` stops with compilation errors (`building wheel failed`) | The Python version is too new for the packages | Install Python 3.12.x and select it as the kernel (see A.1) |
| The € sign or other special characters look wrong | An encoding problem in the editor | Make sure the file is opened as UTF-8; if needed download it from the repository again |
| Your results differ from the numbers in the study text | The input data was changed while experimenting | Download the notebook from the repository again. Save your own changes in a copy first |

If an error message still stops you after checking these points, you can also
paste it into an AI tool of your choice (e.g. ChatGPT or Claude) and let
it help you with the analysis.

# Part B: GAMS

## B.1 Install GAMS

1. Open the download page: **<https://www.gams.com/download/>**
2. Choose the installer for your operating system (Windows 64 bit, macOS with Apple Silicon or Intel, Linux). For working with GAMS, it is recommended to download and install the latest available version whenever possible.
3. Install with the default settings. **GAMS Studio**, the graphical working environment, is installed automatically. You do not need any other editor.

## B.2 Set up your licence

**Free licence for students (recommended):**

1. Open the page of the academic programme:
   **<https://www.gams.com/academics/>**
2. Register in the GAMS Portal (**<https://portal.gams.com>**) **with your
   university e-mail address** (your FernUniversität address). Your eligibility
   is checked through this address.
3. Confirm the registration e-mail. This step is required.
4. Create a free licence in the portal and copy the access code that is shown.
5. In GAMS Studio, click **Help** in the menu bar at the top, then
   **GAMS Licensing**. Paste your access code into the **Access Code** field and
   click **Install License**. You can then close the window with **OK** at the
   bottom right.

**Without registering:** GAMS comes with a **demo licence** that is already
included. All models in this course are small enough to run under it. The demo
licence is valid for five months only.

## B.3 Set HiGHS as the default solver (important)

Please set the solver **HiGHS** before your first model run. Otherwise GAMS will
use a different solver, and in time step 2 you will get a different price than
the one printed in the study text.

HiGHS is a free solver and is already part of every GAMS installation. You do not
need an extra licence for it.

### How to set HiGHS permanently

You only have to do this once. It then applies to all your GAMS models.

1. In GAMS Studio, click **GAMS** in the menu bar at the top.
2. Choose **Default GAMS Configuration**. A sheet named **`gamsconfig.yaml`**
   opens.
3. On the right, type **`LP`** into the search field **Filter Parameters**.
4. Select the entry **LP** from the list using the drop-down menu. The list of
   available solvers now appears on the right.
5. Find **HIGHS** in the solver list and **double-click** it.
6. In the window that opens, click **Replace existing entry**.
7. Close the open **`gamsconfig.yaml`** sheet at the top using the cross on the
   tab.
8. A prompt appears. Click **Save**.

That is it. HiGHS is now the default solver for linear models.

### Alternative for a single model run

If this does not work for you, or if you do not want to change the default, you
can also set the solver inside the model file. Add this line to
`BasicModel.gms` directly **before** the line
`Solve merit_order using LP minimizing C_op;`:

```gams
option LP = HiGHS;
```

A setting inside the model file overrides the default configuration.

## B.4 Open and run the model

1. Start GAMS Studio.
2. Choose **File > Open** and select `BasicModel.gms`. Studio creates a project
   for it automatically.
3. Run the model: the **Run** button or the **F9** key.
4. Follow the run in the **Process Log** in the panel on the right-hand side. It
   has to end with the message **`Normal completion`**. The run takes a few
   seconds at most.

## B.5 Looking at the results: log, listing, GDX and Excel

A model run produces several files in the model folder. The study text
(Step 2 of the GAMS tasks) asks you to look at all of them.

| File | What it contains |
|---|---|
| `BasicModel.log` | The same compilation, solver and completion messages you see in the Process Log. The first file to open when a run does not end normally |
| `BasicModel.lst` | The solution listing: model statistics, solve summary, variable levels and equation marginals |
| `BasicModel.gdx` | Written automatically at the end of the GAMS job |
| `results_unitcommitment.gdx` | Written by the `execute_unload` statement in the model. Contains all sets, parameters, variables and equations |
| `results_unitcommitment.xlsx` | Written by the two GDXXRW statements. |

### B.5.1 Opening a GDX file in GAMS Studio (works on every system)

1. After a successful run, `results_unitcommitment.gdx` appears in the
   `Project Explorer` on the left. **Double-click** the file. Studio opens the
   built-in **GDX Viewer**.
2. On the left you see all symbols of the model (`i`, `t`, `D`, `y_max`,
   `c_var`, `y`, `C_op`, `objfunc`, `loadserve`, `maxcap`).
3. Click a symbol to see its values. Two symbols matter most in this chapter:

   | Symbol | Column | Meaning |
   |---|---|---|
   | `y` (variable) | **Level** | Generation of each plant in each time step, in MW |
   | `loadserve` (equation) | **Marginal** | Dual value of the load-serving constraint, that is the market price in €/MWh |

Everything the study text asks you to read from the Excel workbook can be read
here as well: the `Level` column of `y` is the `Gen` worksheet, and the
`Marginal` column of `loadserve` is the `Prices` worksheet.

### B.5.2 Moving single results into a spreadsheet

If you want to do your own calculations with the results, for example adding
them up, sorting them or drawing your own charts, copy the values into a
spreadsheet program (Excel, LibreOffice Calc, Google Sheets):

- **Copy and paste:** In the GDX Viewer, select the rows you need, copy them with
  `Ctrl + C` (macOS: `Cmd + C`) and paste them into a worksheet. Watch the
  decimal separator: GAMS writes a full stop, while some regional settings expect
  a comma. If the numbers arrive as text, use *Data > Text to Columns* to fix
  them.

## B.6 The two extended models

Sections 2.4.2 and 2.4.3 of the study text ask you to build two larger models
yourself, each starting from a copy of `BasicModel.gms`:

- **`TransmissionModel.gms`** adds a second region, regional demand, directional
  power flows and a transmission limit. The single system-wide price is replaced
  by two regional prices.
- **`InvestmentModel.gms`** turns installed capacity from a fixed parameter into
  a decision variable, adds annualised investment costs, unserved load and the
  value of lost load. The model then chooses the capacity mix itself.

Please work through these tasks with the study text open. It tells you which
sets, parameters, variables and equations to add, and in which order. Compiling
the file after each step and reading the Process Log is part of the exercise.

## B.7 Common GAMS error messages

| Message in the Process Log | Cause | What to do |
|---|---|---|
| `*** No license found` | No licence, an expired licence, or the chosen solver is not licensed | Set up the licence as in B.2; set HiGHS as in B.3 |
| `Cannot execute gdxxrw.exe`, or a return code other than 0 at the end | No Windows, or no Excel installed | Not an error, see B.5.1. Carry on with the GDX file |
| `Error 140`, `Unknown symbol` | A typing mistake while editing the code | Go to the line number given in the log; if needed, download the original file again |
| `Error 257`, `Solve statement not checked` | An earlier compilation error stops the run | Fix the first error message in the log. The later ones usually follow from it |
| The run ends with `Infeasible` | Demand is higher than the total available capacity. This usually happens after you change `D(t)` or `y_max(i)` yourself | Check your values |
| The price in time step 2 is 62.61 instead of 61.50 | The model was solved with a different solver | Set HiGHS as in B.3 |

## 5. Which file to use when

The study text contains task boxes at the relevant places. They tell you which
sections of the notebook or which model files to run. For orientation:

| Study text | Material | Sections or steps |
|---|---|---|
| 2.4.1.1 Getting started | Notebook | Sections 1 and 2 |
| 2.4.1.1 Building the merit order | Notebook | Sections 3 and 4 |
| 2.4.1.1 Exploring the supply curve | Notebook | Section 5 |
| 2.4.1.2 Inframarginal rents | Notebook | Section 6 |
| 2.4.1.2 The merit-order effect of renewables | Notebook | Sections 7 and 8 |
| 2.4.1.2 The fuel switch | Notebook | Section 9 |
| 2.4.1.2 Self-cannibalisation | Notebook | Section 10 |
| 2.4.1.3 The optimisation model | GAMS | `BasicModel.gms`, Steps 1 to 4 |
| 2.4.2 Interactive market splitting | Notebook | Section 11 |
| 2.4.2 Transmission constraints | GAMS | `TransmissionModel.gms`, Steps 5 and 6 |
| 2.4.3 Interactive peak-load pricing | Notebook | Section 12 |
| 2.4.3 Long-term investment | GAMS | `InvestmentModel.gms`, Steps 7 and 8 |

The exercises at the end of the chapter do not require any of these files, but they are a good way to check your results.
