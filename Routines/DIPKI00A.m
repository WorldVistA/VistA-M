DIPKI00A ; ; 30-MAR-1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I DSEC F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(9.4,0,"DD")
 ;;=#
 ;;^DIC(9.4,0,"DEL")
 ;;=#
 ;;^DIC(9.4,0,"LAYGO")
 ;;=#
 ;;^DIC(9.4,0,"WR")
 ;;=#
