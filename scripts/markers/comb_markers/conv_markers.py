import scanpy as sc
import matplotlib.pyplot as plt

def generate_dotplot(h5ad_file, marker_genes, output_file):
    # Load the AnnData object from the .h5ad file
    adata = sc.read(h5ad_file)

    # Specify the marker genes for the dot plot
    marker_genes = marker_genes

    # Create the dot plot
    sc.pl.dotplot(adata, var_names=marker_genes, groupby='scpred_prediction', color_map='viridis', dot_max=0.7, dendrogram=True, save=output_file)

if __name__ == "__main__":
    # Replace 'your_file.h5ad' with the path to your .h5ad file
    h5ad_file_path = '/storage/chentemp/alice/TM_project/tissue/scrnah5adfiles2scviwkfl/TM_culture_wtissue.h5ad'

    # Replace ['gene1', 'gene2', 'gene3'] with your list of important genes
    marker_gene_list = ['CALB2','UCHL1','SCG2','GAP43','MLANA','PMEL','MITF','TRPM1','TYR','MBP','MPZ','PLP1','LGI4','CDH19','CD27','CD79A','MZB1','LYVE1','CD68','CXCL8','IL1B','TREM2','RGS13','KIT','CD2','CD3D','IL7R','TRAC','CA3','MGARP','ADRB2','SLC2A1','IGFBP2','COL14A1','ADH1B','FBLN2','COL1A2','COL6A1','TNXB','TIMP2','FBLN1','DCN','PCOLCE','PLVAP','FLT4','PROX1','ACKR1','AQP1','SELE','MMRN1','PECAM1','VWF','ALPL']

    # Specify the output file path (e.g., 'dotplot.png')
    output_file_path = 'comb_markers_scpred.png'

    # Generate the dot plot
    generate_dotplot(h5ad_file_path, marker_gene_list, output_file_path)
