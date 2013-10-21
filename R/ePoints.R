ePoints = function(dat, opt=list(), only=FALSE, local=FALSE, style=NULL) {

    if(is.null(opt$toolbox$show)) {
        opt$toolbox$show = TRUE
    }

    if(is.null(opt$toolbox$feature$mark)) {
        opt$toolbox$feature$mark = TRUE
    }

    if(is.null(opt$toolbox$feature$dataView)) {
        opt$toolbox$feature$dataView = TRUE
    }

    if(is.null(opt$toolbox$feature$dataZoom)) {
        opt$toolbox$feature$dataZoom = TRUE
    }

    if(is.null(opt$toolbox$feature$restore)) {
        opt$toolbox$feature$restore = TRUE
    }    
	
	if(is.null(opt$toolbox$feature$saveAsImage)) {
        opt$toolbox$feature$saveAsImage = TRUE
    }  

    if(is.null(opt$tooltip$trigger)) {
        opt$tooltip$trigger = 'item'
    }	

	if(is.null(opt$xAxis$type)) {
		opt$xAxis$type = 'value'
	}
	if(is.null(opt$xAxis$power)) {
		opt$xAxis$power = 1
	}
	if(is.null(opt$xAxis$precision)) {
		opt$xAxis$precision = 1
	}
	if(is.null(opt$xAxis$scale)) {
		opt$xAxis$scale = TRUE
	}			

	if(is.null(opt$yAxis$type)) {
		opt$yAxis$type = 'value'
	}
	if(is.null(opt$yAxis$power)) {
		opt$yAxis$power = 1
	}
	if(is.null(opt$yAxis$precision)) {
		opt$yAxis$precision = 1
	}
	if(is.null(opt$yAxis$scale)) {
		opt$yAxis$scale = TRUE
	}			


    if(dim(dat)[2]>3|dim(dat)[2]<2) {
        stop("dim(dat)[2] should be 2 or 3.")
    }

    if(dim(dat)[2]==3){
        dat[,3] = as.character(dat[,3])     
        dat = dat[order(dat[,3]),] 
        if(is.null(opt$legend$data)) {
            names = unique(dat[,3])
            opt$legend$data = names
        }  
    } else {
        names = NA
    }



    if(is.null(opt$series)) {
        opt$series =  vector("list", length(names))
    } else if(length(opt$series)!=length(names)) {
        stop('Lengh of opt:series should be the same with nol(y).')
    }
    
    for(i in 1:length(names)) {

        if(dim(dat)[2]==2) {
            mat = as.matrix(dat)
        } else {
            mat = as.matrix(dat[which(dat[,3]==names[i]), 1:2])
        }

        colnames(mat) = NULL
        rownames(mat) = NULL

        if(is.null(opt$series[[i]]$type)) {
            opt$series[[i]]$type = 'scatter'
        }

        if(is.null(opt$series[[i]]$name) & dim(dat)[2]==3) {
            opt$series[[i]]$name = names[i]
        } else {
            warning("You'd better set series:name with y.")
        }
        
        if(is.null(opt$series[[i]]$data)) {
            opt$series[[i]]$data = mat
        } else {
            warning('You can set series:data with y.')
        }
    }

    optJSON = RJSONIO::toJSON(opt)
    if(is.null(style)) {
        style = "height:500px;border:1px solid #ccc;padding:10px;"
    }

    invisible(configHtml(opt=optJSON, only=only, local=local, style=style))
}