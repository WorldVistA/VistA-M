SCCVEGU1 ;ALB/TMP - UTILS FOR ENCNTR CNVRSN GLBL ESTMTR;20-JAN-1998
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
INCRTOT(SCTOT,INCRWHAT,HOWMUCH) ;Update local counters for estimate
 ; SCTOT -- The array containing the running estimate totals
 ;         Subcripted by the piece it is stored on in the CST's node 2
 ; INCRWHAT -- The piece of the CST 2-node that stores the correspnding count
 ;                      1 = Add/edits (Default)
 ;                      2 = Ancillaries
 ;                      3 = Appointments
 ;                      4 = Credit stops
 ;                      5 = Dispositions
 ;                      7 = Encounters and Visits
 ;                      8 = Visits only
 ;                      9 = # V-Providers
 ;                     10 = # V-Diagnoses
 ;                     11 = # V-Procedures
 ; HOWMUCH -- The amount to add to the existing total
 ;
 ;OUTPUT :
 ;  SCTOT(INCRWHAT) -- local array to hold the # found
 ;
 I $G(HOWMUCH)="" N HOWMUCH S HOWMUCH=1
 S SCTOT(+INCRWHAT)=$G(SCTOT(+INCRWHAT))+HOWMUCH
 I +INCRWHAT=7 S SCTOT(8)=$G(SCTOT(8))+HOWMUCH
 Q
 ;
UPDTOTL(PTRLOG,SCTOT) ;UPDATE CST WITH ESTIMATE TOTALS
 ;INPUT  : PTRLOG - Pointer to entry in SCHEDULING CONVERSION TEMPLATE
 ;                  file (#404.98)
 ;         SCTOT  - Array subscripted by storage pc and containing
 ;                  the totals to be stored for the estimate
 ;OUTPUT : None
 ;
 N SC2,SCDATA,SCF
 Q:'$D(^SD(404.98,+$G(PTRLOG),0))
 S SC2=0 F  S SC2=$O(SCTOT(SC2)) Q:'SC2  S SCF="2."_$S($L(SC2)<2:"0",1:"")_SC2,SCDATA(+SCF)=SCTOT(SC2)
 ; -- Update count(s)
 D UPD^SCCVDBU(404.98,PTRLOG,.SCDATA)
 Q
 ;
ESTGROW(ARRAY) ;RETURN ESTIMATED GLOBAL GROWTH FOR AFFECTED GLOBALS
 ;INPUT  : ARRAY - Array to store output in (full global reference)
 ;                   Defaults to ^TMP("SCCVEG",$J,"SIZE")
 ;OUTPUT : None
 ;         ARRAY will be returned as follows
 ;           ARRAY(GLOBAL) = Estimated global growth
 ;             Where GLOBAL will be
 ;               SCE,
 ;               AUPNVCPT, AUPNVPOV, AUPNVPRV, AUPNVSIT  <- PCE Globals
 ;
 N X,Y
 S:($G(ARRAY)="") ARRAY="^TMP(""SCCVEG"","_$J_",""SIZE"")"
 K @ARRAY
 ;
 ; Sets # of blocks per record by global at 70% Global Efficiency
 ;
 S @ARRAY@("SCE","NEW")=$$SCE() ; New encounters
 S @ARRAY@("SCE","UPD")=$$SCEUPD() ; Updated encounters (visit pointer/convert)
 S @ARRAY@("AUPNVSIT")=$$AUPNVSIT() ; visits
 S @ARRAY@("AUPNVCPT")=$$AUPNVCPT() ; procedures
 S @ARRAY@("AUPNVPRV")=$$AUPNVPRV() ; providers
 S @ARRAY@("AUPNVPOV")=$$AUPNVPOV() ;  diagnoses
 Q
 ;
FACTOR() ; -- determine block factor (1 := 1024/dsm  2 := 2048/openm)
 Q $S($G(^%ZOSF("OS"))["DSM":1,1:2)
 ;
BLKSIZE() ; -- determine block size
 Q $S($$FACTOR()=1:1024,1:2048)
 ;
PER(EST) ; -- adjust 'per' record size for os
 Q $J(EST/$$FACTOR(),4,3)
 ;
 ; -- block per entry estimates for dsm (1024 bytes per block)
SCE() ; -- encounter
 Q $$PER(.288)
SCEUPD() ; -- encounter update only
 Q $$PER(.147)
AUPNVSIT() ; -- visit file
 Q $$PER(.336)  ; original est. was .325
AUPNVPRV() ; -- providers
 Q $$PER(.139)  ; original est. was .145
AUPNVPOV() ; -- dx
 Q $$PER(.163)  ; original est. was .132
AUPNVCPT() ; -- cpts
 Q $$PER(.196)  ; original est. was .159
 ;
