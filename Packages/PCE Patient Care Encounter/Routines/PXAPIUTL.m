PXAPIUTL ;ISL/dee - some of PCE's utilities used by PCE's API ;3/14/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,186**;Aug 12, 1996;Build 3
 Q
 ;
SOURCE(X) ;Get IEN of data source in the PCE Data Source file
 N DIC,Y,DLAYGO
 S DIC="^PX(839.7,"
 S DLAYGO=839.7
 S DIC(0)="LMNOX"
 D ^DIC
 Q +Y
 ;
TMPSOURC(X) ;Gets the IEN of the data source the builds the ^TMP("PXK" node for it
 S ^TMP("PXK",$J,"SOR")=$$SOURCE(X)
 Q
 ;
PRVCLASS(PROVIDER,VISITDT) ;See if this is a good provider
 ;Call with a pointer to $VA(200, and a date
 ; (if no date is passed then it defauts to DT) and returns 
 ;IEN^Occupation^specialty^sub-specialty^Effective date^expiration date
 ; if + of the return is >0 provider is active
 ; else -1 the provider is not active or bad call
 ; else -2 if no current person class.
 ;
 S:VISITDT="" VISITDT=DT
 Q:VISITDT<1800000 -1
 Q:'$D(^VA(200,+PROVIDER,0)) -1
 ;
 N PXACTIVE
 S PXACTIVE=$P(^VA(200,PROVIDER,0),"^",11)
 I PXACTIVE'="",PXACTIVE<VISITDT Q -1
 Q $$GET^XUA4A72(PROVIDER,$P(VISITDT,"."))
 ;
