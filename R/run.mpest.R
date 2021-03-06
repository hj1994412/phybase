'run.mpest'<-function(path_mpest="mpest", genetreefile, species, sptree="", ntree)
{
	nspecies = length(species)
	if(nchar(sptree) == 0){
		x = c(genetreefile, "0", "-1", "1", paste(ntree, nspecies), paste(species, 1, species), "0", sptree)
    	}else{
    		x = c(genetreefile, "0", "-1", "1", paste(ntree, nspecies), paste(species, 1, species), "2", sptree)
    	}
	controlfile = paste("control_",genetreefile,sep="")
	write(x,controlfile)
	try(system(paste(path_mpest,controlfile)))

	x = scan(paste(genetreefile,"_besttree.tre",sep=""),what="character",sep="\n")
	x = x[grep("tree mpest",x)]
	loglike = as.numeric(unlist(strsplit(unlist(strsplit(x,"\\["))[2], "\\]"))[1])
	tree = read.tree.string(paste(genetreefile,"_besttree.tre",sep=""))$tree
	z = list(tree = "", loglike=as.numeric)
	z$loglike = loglike
	z$tree = tree
	z
}
