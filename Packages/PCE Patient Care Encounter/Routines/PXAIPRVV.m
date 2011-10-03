PXAIPRVV ;ISL/JVS - VALIDATE THE PROVIDER DATA ;3/19/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,186**;Aug 12, 1996;Build 3
 ;
 ;
 Q
 ;
VAL ;--VALIDATE ENOUGH DATA
 ;
 ;
 ;----Missing a pointer to providers name
 I $G(PXAA("NAME"))']"" D  Q:$G(STOP)
 .S STOP=1 ;--USED TO STOP DO LOOP
 .S PXAERRF=1 ;--FLAG INDICATES THERE IS AN ERR
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="NAME"
 .S PXAERR(11)=$G(PXAA("NAME"))
 .S PXAERR(12)="You are missing a pointer to the NEW PERSON file #200 that represents the providers name"
 ;
 ;----Not a pointer to NEW PERSON file#200
 I $G(PXAA("NAME"))'["@" D 01^PXAIUPRV($G(PXAA("NAME"))) I $G(PXAIVAL)=1 K PXAIVAL,PXCA("ERROR") D  Q:$G(STOP)
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="NAME"
 .S PXAERR(11)=$G(PXAA("NAME"))
 .S PXAERR(12)=PXAERR(11)_" is NOT a pointer value to the NEW PERSON file #200"
 ;
 ;----Not have an active person class
 N CLASS
 S CLASS=+$$GET^XUA4A72($G(PXAA("NAME")),$P(+$G(^AUPNVSIT(PXAVISIT,0)),".")) I CLASS<0,'$G(PXAA("DELETE")) D
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="NAME"
 .S PXAERR(11)=$G(PXAA("NAME"))
 .S PXAERR(12)="The Provider does not have an ACTIVE person class!"
 Q
VAL04 ;---SET UP INFORMATION TO DELIVER ERROR
 D
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.002
 .S PXAERR(9)="PRIMARY"
 .S PXAERR(11)=$G(PXAA("PRIMARY"))
 .S PXAERR(12)="Another provider has been previously designated as the PRIMARY provider for this patient encounter. "_PXAAX("NAME")_" will be saved as s secondary provider."
 .S PXAERR(13)="If you whish to change the PRIMARY PROVIDER designation for this encounter, please use one of PCE'S interactive interfaces."
 ;
 Q
