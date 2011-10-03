DIAXERR ;SFISC/DCM-EXTRACT MAPPING UTILITIES ;5/1/96  16:49
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ERR(A) ;
 Q:'$D(A)  N DIAXMSG
 S DIPG=+$G(DIPG),DIERR=($G(DIERR)+1)_U_($P($G(DIERR),U)+1)
 S DIAXMSG=$S(+A:$P($T(@(+A)),";",3),1:A)
 I DIPG S ^TMP("DIERR",$J,+DIERR)="",^(+DIERR,"TEXT",1)=DIAXMSG Q
 E  D EN^DDIOL(DIAXMSG)
 Q
5 ;;Destination file does not exist
6 ;;Mapping information does not exist
7 ;;Extract field does not exist
8 ;;Field in destination file does not exist
