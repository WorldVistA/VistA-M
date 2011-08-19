PRCPUXRE ;WISC/RFJ-xref for file 445.2 and 445.3                    ;24 May 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
XREFAX(DA,X,FIELD,SETKILL) ;  build xref for 445.2
 ;  da = internal entry number
 ;  x = value of data in field
 ;  field = field number for x
 ;  setkill = "SET" to set; "KILL" (or anything other than set) to kill
 N %,DATE,INVPT,TYPETRAN
 S %=$G(^PRCP(445.2,DA,0)) I %="" Q
 S INVPT=+$P(%,"^"),TYPETRAN=$P(%,"^",4),DATE=+$P($P(%,"^",17),".")
 D
 .   I FIELD=.01 S INVPT=X Q
 .   I FIELD=2.5 S DATE=X Q
 .   I FIELD=3 S TYPETRAN=X
 I 'INVPT!(TYPETRAN="")!('DATE) Q
 I SETKILL="SET" S ^PRCP(445.2,"AX",INVPT,DATE,TYPETRAN,DA)="" Q
 K ^PRCP(445.2,"AX",INVPT,DATE,TYPETRAN,DA)
 Q
 ;
 ;
XREFASR(DA,X,FIELD,SETKILL)  ;  build xref for file 445.3
 ;  da = internal entry number
 ;  x = value of data in field
 ;  field = field number for x
 ;  setkill = "SET" to set; "KILL" (or anything other than set) to kill
 N %,PATDA,SURGDA
 S %=$G(^PRCP(445.3,DA,2)) I %="" Q
 S PATDA=+$P(%,"^"),SURGDA=+$P(%,"^",2)
 D
 .   I FIELD=129 S PATDA=X Q
 .   I FIELD=130 S SURGDA=X Q
 I 'PATDA!('SURGDA) Q
 I SETKILL="SET" S ^PRCP(445.3,"ASR",PATDA,SURGDA,DA)="" Q
 K ^PRCP(445.3,"ASR",PATDA,SURGDA,DA)
 Q
