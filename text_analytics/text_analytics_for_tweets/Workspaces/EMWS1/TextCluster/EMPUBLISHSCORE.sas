%tmc_doc_score(import=&em_score_output,export=work._newexport,
termds=termloc.TextFilter_filtterms, configds=termloc.TextCluster_tmconfig,
clusters=termloc.TextCluster_clusters, emoutstat=termloc.TextCluster_emoutstat,
_scrout=work.TextFilter_out, svd_u=termloc.TextCluster_svd_u, svd_s=termloc.TextCluster_svd_s, prefix=TextCluster);
data &em_score_output; set work._newexport;
