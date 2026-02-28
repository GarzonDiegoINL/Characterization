# Characterization

Python notebooks and an ImageJ macro for characterization and analysis of thin-film solar cells and thin-film optical properties.

---

## Notebooks

| Notebook | Purpose | Inputs | Outputs | References |
|---|---|---|---|---|
| [DOE_creation_analysis](DOE_creation_analysis.ipynb) | Creates full/fractional factorial Design of Experiments tables and analyzes results via Ordinary Least Squares (OLS) regression or Bayesian optimization (Ax platform). | Excel file with experimental results | `DOE plan.xlsx`, `OLS output.txt`, `Bayesian optimization output.xlsx`, contour plots | [Ax platform docs](https://ax.dev/docs/tutorials/gpei_hartmann_service/) |
| [EDX_PFD_files_reader](EDX_PFD_files_reader.ipynb) | Extracts atomic percentages of Cu, In, Ga, Se from EDX `.pdf` reports and computes CIGS compositional ratios: CGI = Cu/(Ga+In), GGI = Ga/(Ga+In), SCGI = Se/(Cu+Ga+In). | EDX `.pdf` files | `EDX results.xlsx` | |
| [EQE_analysis](EQE_analysis.ipynb) | Computes short-circuit current density $J_{sc}$ by integrating EQE with the AM1.5G spectrum, and extracts the band gap $E_g$ via sigmoid fit (Almora) and linear Keller method. | EQE `.txt` files | `Parameters from EQE.xlsx`, individual EQE plots | [TU Delft OCW](https://ocw.tudelft.nl/wp-content/uploads/solar_energy_section_9_2.pdf) · [Almora et al., *Adv. Energy Mater.* 2021](https://onlinelibrary.wiley.com/doi/epdf/10.1002/aenm.202100022) · [Keller, ResearchGate](https://www.researchgate.net/publication/352019926) |
| [LBIC_colormap](LBIC_colormap.ipynb) | Generates 2D current colormaps from Light Beam Induced Current (LBIC) scan data with a consistent color scale across all samples. | LBIC `.txt` matrix files | Individual and combined colormap figures | |
| [Parser_for_STAR_logs](Parser_for_STAR_logs.ipynb) | Parses `.log` files from a STAR sputtering system, handles RF and DC configurations, and produces multi-panel diagnostic plots of power, voltage, current, gas flows, and temperature. | STAR `.log` files | Multi-panel plots, `processed_data_*.csv` | |
| [Solar_Cells_Analysis](Solar_Cells_Analysis.ipynb) | Processes solar simulator outputs to produce boxplots of $V_{oc}$, $J_{sc}$, PCE, FF, $R_s$, $R_{sh}$; plots best-cell JV curves; and extracts the ideality factor from dark and light IV curves. | Solar simulator Results Table and IV Graph `.txt` files | Boxplot PNG, `Parameters from ideality factor.xlsx` | [Hegedus & Shafarman, *Prog. Photovolt.* 2004](https://onlinelibrary.wiley.com/doi/abs/10.1002/pip.518) · [Zhang et al., *J. Appl. Phys.* 2011](https://pubs.aip.org/aip/jap/article-abstract/110/6/064504/151473/) |
| [Tauc_Plot_analysis](Tauc_Plot_analysis.ipynb) | Calculates the optical band gap of thin films from UV-Vis transmittance/reflectance data using the Tauc plot method and the Zanatta Sigmoid-Boltzmann fitting approach. | UV-Vis `.csv` files (T & R), `thickness.xlsx` | `results_tauc_plot.xlsx`, Tauc and Boltzmann fit PNGs | [Makula et al., *J. Phys. Chem. Lett.* 2018](https://pubs.acs.org/doi/10.1021/acs.jpclett.8b02892) · [Wikipedia: Tauc plot](https://en.wikipedia.org/wiki/Tauc_plot) · [Zanatta, *Sci. Rep.* 2019](https://www.nature.com/articles/s41598-019-47670-y) |

---

## ImageJ Macro

| File | Purpose | Usage |
|---|---|---|
| [Thickness measurement.ijm](Thickness%20measurement.ijm) | Measures thin-film thickness from SEM cross-section images by computing the pixel distance between two user-drawn line ROIs and converting to physical units using the image calibration scale. | Open in Fiji/ImageJ and run interactively on a calibrated SEM image. |

---

## Requirements

**Python packages** (install via `pip`):

```
numpy pandas matplotlib scipy seaborn statsmodels
dexpy pypdf chardet scikit-learn plotly ax-platform
```

**ImageJ macro:** requires [Fiji](https://imagej.net/software/fiji/) or ImageJ with a calibrated SEM image.
