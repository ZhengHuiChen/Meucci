#' This script considers a bivariate lognormal market and display the correlation and the condition number of the
#' covariance matrix, as described in A. Meucci, "Risk and Asset Allocation", Springer, 2005,  Chapter 2.
#'
#' @references 
#' A. Meucci - "Exercises in Advanced Risk and Portfolio Management" \url{http://symmys.com/node/170}, 
#' "E 85 - Correlation in lognormal markets".
#'
#' See Meucci's script for "S_AnalyzeLognormalCorrelation.m"
#'
#' @author Xavier Valls \email{flamejat@@gmail.com}
#' 


###########################################################################################################################################
### Set input parameters
Mu = rbind( 0, 0 )
s  = c( 1, 1 );
rhos = seq( -0.99, 0.99, 0.01 );
nrhos = length( rhos );
Cs = array( NaN, nrhos ); 
CRs = array( NaN, nrhos ); 

###########################################################################################################################################
### Iterate of rho values and compute the correlation and condition number

for ( n in 1 : nrhos )
{
    rho = rhos[ n ] ;
    Sigma = rbind( c(s[1]^2, rho * s[1] * s[2]), c(rho * s[1] * s[2], s[2]^2) );

    S = LognormalParam2Statistics(Mu, Sigma);       
    
    Lambda = eigen(S$Covariance);

    Cs[ n ]  = S$Correlation[1, 2];
    CRs[ n ] = min(Lambda$values) / max(Lambda$values);
}

###########################################################################################################################################
### Display the results

par( mfrow = c( 2, 1) );
plot( rhos, Cs, xlab = "r", ylab = "correlation", type ="l" );
plot( rhos, CRs, xlab = "r", ylab = "condition ratio", type ="l" );
