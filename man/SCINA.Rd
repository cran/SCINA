% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/EM_model.R
\name{SCINA}
\alias{SCINA}
\title{A semi-supervised cell type identification and assignment tool.}
\usage{
SCINA(exp, signatures, max_iter = 100, convergence_n = 10, convergence_rate = 0.99, 
    sensitivity_cutoff = 1, rm_overlap = 1, allow_unknown = 1, log_file = "SCINA.log")
}
\arguments{
\item{exp}{A normalized matrix representing the gene expression levels. The log-transformation is suggested to avoid heavy-tailed datasets. Columns correpond to cells, rows correspond to genes or protein symbols.}

\item{signatures}{A list contains multiple signature vectors. Each signature vector contains genes or protein symbols, representing the prior knowledge for one cell type.}

\item{max_iter}{An integer > 0. Default is 100. Max iterations allowed for the EM algorithm.}

\item{convergence_rate}{A float between 0 and 1. Default is 0.99. Percentage of cells for which the type assignment remains stable for the last n rounds.}

\item{sensitivity_cutoff}{A float between 0 and 1. Default is 1. The cutoff to remove signatures whose cells types are deemed as non-existent at all in the data by the SCINA algorithm.}

\item{rm_overlap}{A binary value, default 1 (TRUE), denotes that shared symbols between signature lists will be removed. If 0 (FALSE) then allows different cell types to share the same identifiers.}

\item{allow_unknown}{A binary value, default 1 (TRUE). If 0 (FALSE) then no cell will be assigned to the 'unknown' category.}

\item{convergence_n}{An integer > 0. Default is 10. Stop the SCINA algorithm if during the last n rounds of iterations, cell type assignment keeps steady above the convergence_rate.}

\item{log_file}{A string names the record of the running status of the SCINA algorithem, default 'SCINA.log'.}
}
\details{ 
  More detailed information can be found from our web server: \url{
  http://lce.biohpc.swmed.edu/scina/.
  }
 
  For any symbols in signature list, if the cell type is identified with symbol X's 
  low detection level, please specify the symbol as 'low_X'. The name for the list is the cell type.
					
  Details for 'low_X' (take scRNA-Seqs as an example):\cr
  (a) There are 4 cell types, the first one highly express one gene A, and the other three lowly express the same gene. 
   Then it is better to specify A as the high marker for cell type 1, but it is not a good idea to specify A as the low 
	expression marker for cell type 2,3,4.\cr
 (b) There are 4 cell types, the first one lowly express one gene A, and the other three highly express the same gene. 
	Then is it better to specify A as the low marker for cell type 1, but it is not a good idea to specify A as the 
	high expression marker for cell type 2,3,4.\cr
 (c) There are 4 cell types, the first one lowly express one gene A, the second and third one moderately express gene A, 
	and the last one highly express gene A. Then is it better to specify A as the low marker for cell type 1, and as the high 
	expression marker for cell type 4.\cr
 (d) The same specification can be applied to protein markers in CyTOF anlysis.
	
  Small sensitivity_cutoff leads to more signatures to be removed, and 1 denotes that no signature is removed.
}
\value{
cell_labels return a vector contains cell type mapping results for each cell.

probabilities return a probability matrix indicating the predicted probability for each cell belongs to each cell type respectively.
}
\description{
An automatic cell type detection and assignment algorithm for single cell RNA-Seq (scRNA-seq) and Cytof/FACS data. See Zhang Z, et al (2019) <doi:10.3390/genes10070531> for more details.
}
\examples{
load(system.file('extdata','example_expmat.RData', package = "SCINA"))
load(system.file('extdata','example_signatures.RData', package = "SCINA"))
exp = exp_test$exp_data
results = SCINA(exp, signatures, max_iter = 120, convergence_n = 12, 
    convergence_rate = 0.999, sensitivity_cutoff = 0.9)
table(exp_test$true_label, results$cell_labels)
}
