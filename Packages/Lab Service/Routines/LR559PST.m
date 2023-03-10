LR559PST ;HPS/DSK - LR*5.2*559 PATCH POST INSTALL ROUTINE ;Jun 02, 2022@16:00
 ;;5.2;LAB SERVICE;**559**;Sep 27, 1994;Build 3
 ;
 Q
 ;
EN ;
 ;This routine is not deleted after install since it is tasked. A future
 ;patch will delete the routine.
 ;
 N LRDUZ
 S ZTRTN="START^LR559PST"
 S ZTDESC="LR*5.2*559 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S LRDUZ=DUZ
 S ZTSAVE("LRDUZ")=""
 D ^%ZTLOAD
 W !!,"LR*5.2*559 Post-Install Routine has been tasked - TASK NUMBER: ",$G(ZTSK)
 W !!,"You as well as members of the LMI MailMan Group will receive"
 W !,"a MailMan message when the search completes.",!
 Q
 ;
START ;
 N LRWRONG,LRCORRECT,LRSEQ,LRTEXT
 ;Initialize ^XTMP in case patch install re-started.
 K ^XTMP("LR 559 MAILMAN MESSAGE")
 S ^XTMP("LR 559 MAILMAN MESSAGE",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^LR*5.2*559 POST INSTALL"
 ;Incorrect execute code for monthly accession areas
 S LRWRONG="S %DT="""",X=""T"" D ^%DT S LRAD=$E(Y,1,5)_""00"" S LRAN=1+$S($D(^LRO(68,LRWLC,1,LRAD,1,0)):$P(^(0),""^"",4),1:0) Q"
 ;Correct execute code for monthly accession areas
 S LRCORRECT="S %DT="""",X=""T"" D ^%DT S LRAD=$E(Y,1,5)_""00"" S LRAN=1+$S($D(^LRO(68,LRWLC,1,LRAD,1,0)):$P(^(0),""^"",3),1:0) Q"
 S LRSEQ=1
 ;Start message with blank line for better readability.
 S LRTEXT=" "
 D LINE
 D LAB6207,LRO68,MAIL
 Q
 ;
LAB6207 ;
 N LREX,LRSTR,LRCHECK,LRHIT,LRFDA,LRMSG
 S LRTEXT="Entries in the EXECUTE CODE (#62.07) file which were corrected:"
 D LINE
 S LRTEXT="---------------------------------------------------------------"
 D LINE
 ;This line will be overwritten if entries are corrected.
 S LRTEXT="None"
 D LINE
 S (LRHIT,LREX)=0
 F  S LREX=$O(^LAB(62.07,LREX)) Q:'LREX  D
 . S LRSTR=$G(^LAB(62.07,LREX,0))
 . I $P(LRSTR,"^",3)'="A" Q
 . I $P(LRSTR,"^",2)'="MONTHLY" Q
 . ;The entry might already have been manually corrected by the site.
 . I $G(^LAB(62.07,LREX,.1))=LRCORRECT Q
 . ;This entry does not match exactly the standard "wrong" execute code,
 . ;so must be manually checked by the site.
 . I $G(^LAB(62.07,LREX,.1))'=LRWRONG D  Q
 . . S LRCHECK(LREX)=""
 . ;This entry must be corrected.
 . S LRFDA(62.07,LREX_",",1)=LRCORRECT
 . D FILE^DIE("","LRFDA","LRMSG")
 . ;First entry which needs correction, so set sequence back by one
 . ;to overwrite the "None" line.
 . I 'LRHIT S LRSEQ=LRSEQ-1,LRHIT=1
 . S LRTEXT=$P(LRSTR,"^")_" (IEN: "_LREX_")"
 . I $D(LRMSG) S LRTEXT=LRTEXT_" *** Check this entry; FileMan returned an error. ***"
 . D LINE
 ;List any entries which might require manual correction.
 ;Or maybe the site intends these entries to be set "as is".
 I $D(LRCHECK) D
 . S LRTEXT=" "
 . D LINE
 . S LRTEXT="The following entries in the EXECUTE CODE (#62.07) file must be"
 . D LINE
 . S LRTEXT="checked manually and evaluated as to whether correction is needed."
 . D LINE
 . S LRTEXT="------------------------------------------------------------------"
 . D LINE
 . S LREX=""
 . F  S LREX=$O(LRCHECK(LREX)) Q:LREX=""  D
 . . S LRTEXT=$P(^LAB(62.07,LREX,0),"^")_" (IEN: "_LREX_")"
 . . D LINE
 Q
 ;
LRO68 ;
 N LRAA,LRFDA,LRMSG,LRHIT,LRCHECK
 S LRTEXT=" "
 D LINE
 S LRTEXT="Entries in the ACCESSION (#68) file which were corrected:"
 D LINE
 S LRTEXT="---------------------------------------------------------"
 D LINE
 ;This line will be overwritten if entries are corrected.
 S LRTEXT="None"
 D LINE
 S (LRAA,LRHIT)=0
 F  S LRAA=$O(^LRO(68,LRAA)) Q:'LRAA  I $P($G(^LRO(68,LRAA,0)),"^",3)="M" D
 . ;Execute code might have already been corrected manually.
 . Q:$G(^LRO(68,LRAA,.1))=LRCORRECT
 . I $G(^LRO(68,LRAA,.1))'=LRWRONG D  Q
 . . S LRCHECK(LRAA)=""
 . ;This entry needs correction.
 . S LRFDA(68,LRAA_",",.051)=LRCORRECT
 . D FILE^DIE("","LRFDA","LRMSG")
 . ;First entry which needs correction, so set sequence back by one
 . ;to overwrite the "None" line.
 . I 'LRHIT S LRSEQ=LRSEQ-1,LRHIT=1
 . S LRTEXT=$P(^LRO(68,LRAA,0),"^")
 . I $D(LRMSG) S LRTEXT=LRTEXT_" *** Check this entry; FileMan returned an error. ***"
 . D LINE
 I $D(LRCHECK) D
 . S LRTEXT=" "
 . D LINE
 . S LRTEXT="The ACC CODE (#.051) field in the ACCESSION (#68) file for the"
 . D LINE
 . S LRTEXT="following accession areas must be checked manually and evaluated"
 . D LINE
 . S LRTEXT="as to whether correction is needed."
 . D LINE
 . S LRTEXT="----------------------------------------------------------------"
 . D LINE
 . S LRAA=""
 . F  S LRAA=$O(LRCHECK(LRAA)) Q:LRAA=""  D
 . . S LRTEXT=$P(^LRO(68,LRAA,0),"^")
 . . D LINE
 Q
 ;
LINE ;
 S LRSEQ=LRSEQ+1
 S ^XTMP("LR 559 MAILMAN MESSAGE",LRSEQ)=LRTEXT
 Q
 ;
MAIL ;
 N LRMIN,LRMY,LRMSUB,LRMTEXT
 S LRMIN("FROM")="LR*5.2*559 Post-Install"
 S LRMY(LRDUZ)=""
 S LRMY("G.LMI")=""
 S LRMSUB="LR*5.2*559 Post-Install"
 S LRMTEXT="^XTMP(""LR 559 MAILMAN MESSAGE"")"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,"","")
 Q
