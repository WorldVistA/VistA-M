GMRCTIUL ;SLC/DCM,DLT - Get list of existing results for consults ;5/01/98  10:09
 ;;3.0;CONSULT/REQUEST TRACKING;**4,14,15**;DEC 27, 1997
 ;
 ; This routine invokes IA #2834
 ;
GETLIST(GMRCO,GETWHAT,TYPE,GMRCNT) ;Get the count and list of results
 ;Input variables:
 ;GMRCO=consult entry from 123
 ;GETWHAT=how much to return
 ;       0 = count only returned
 ;       1 = count + ^TMP internal values from TIU
 ;       2 = count + ^TMP internal values from TIU
 ;                 + ^TMP display format array
 ;TYPE=what type of results to return
 ;       0=all types
 ;       1=TIU only
 ;       2=Medicine results only
 ;returns GMRCNT() = result count
 ;        ^TMP("GMRC50",$J,GMRCRVP,GMRCRIEN)=summary data from source
 ;             where GMRCRVP is the variable pointer value
 ;             where GMRCRIEN is the entry in the 50th node
 ;        ^TMP("GMRC50R",$J,GMRCRIEN)= external list for review
 N COUNT,GMRCRIEN,TAB
 K ^TMP("GMRC50",$J),^TMP("GMRC50R",$J),GMRCNT
 S (COUNT,GMRCRIEN)=0,GMRCNT(0)=COUNT
 S TAB="",$P(TAB," ",30)=""
 ;Get results from the result multiple
 F  S GMRCRIEN=$O(^GMR(123,+GMRCO,50,GMRCRIEN)) Q:'GMRCRIEN  D  I $G(GMRCQUT) K GMRCQUT Q
 . S GMRCRVP=$P($G(^GMR(123,+GMRCO,50,+GMRCRIEN,0)),"^",1) I GMRCRVP="" S GMRCQUT=1 Q
 . D UPDCNT
 . Q
 ;Get TIU NARRATIVE RESULT if the result multiple is not loaded yet
 I COUNT=0,'$D(^GMR(123,+GMRCO,50)),+$P(^GMR(123,+GMRCO,0),"^",20) D
 . S GMRCRVP=$P($G(^GMR(123,+GMRCO,0)),"^",20)_";TIU(8925,"
 . D UPDCNT
 . Q
 S GMRCNT(0)=COUNT
 Q
 ;
UPDCNT ;Update count of existing results for the consult and build array
 S GMRCVF=$P(GMRCRVP,";",2)
 I '$G(GMRCNT(GMRCVF)) S GMRCNT(GMRCVF)=0
 S COUNT=COUNT+1
 S GMRCNT(GMRCVF)=GMRCNT(GMRCVF)+1
 I +GETWHAT,TYPE=1 D TIUTMP(+GETWHAT)
 Q
 ;
TIUTMP(GETWHAT) ;build ^TMP array for results based on TIU when type=1
 I $G(GMRCRVP)["MCAR" D  Q
 .S COUNT=COUNT-1
 .S GMRCNT(GMRCVF)=GMRCNT(GMRCVF)-1
 S ^TMP("GMRC50",$J,GMRCRVP,COUNT)=$$RESOLVE^TIUSRVLO(+GMRCRVP)
 Q:GETWHAT=1  ;get internal value global
 N GMRCRDAT,GMRCDOCT,GMRCEDT,GMRCAUTH,GMRCSTS,GMRCTX
 S GMRCRDAT=^TMP("GMRC50",$J,GMRCRVP,COUNT)
 S GMRCDOCT=$E($P(GMRCRDAT,"^",1),1,19)
 S GMRCEDT=$$FMTE^XLFDT($P(GMRCRDAT,U,2),"D")
 S GMRCAUTH=$E($P($G(^VA(200,+$P(GMRCRDAT,"^",4),0)),U,1),1,12)
 S GMRCSTS=$E($P(GMRCRDAT,"^",6),1,5)
 S GMRCTX=$J(COUNT,3)_"> "_$E(GMRCDOCT_TAB,1,20)_$E("#"_+GMRCRVP_TAB,1,9)_$E(GMRCEDT_TAB,1,13)_$E(GMRCAUTH_TAB,1,14)_$E(GMRCSTS_TAB,1,6)_$E("#"_+$P(GMRCRDAT,"^",9)_TAB,1,10)
 S ^TMP("GMRC50R",$J,COUNT,GMRCRVP)=GMRCTX
 Q
 ;
PROCTMP ;build ^TMP array for procedure results when type note=1
 Q:TYPE=1
 Q
 ;
SHOWTIU ;Display the current TIU results available
 N GMRCRVP,GMRCRCT
 W !,"Notes associated with this consult:",!
 W !," No.  Document Title       TIU    Entered      Author        Sts  Consult"
 S GMRCRCT=0
 F  S GMRCRCT=$O(^TMP("GMRC50R",$J,GMRCRCT)) Q:'+GMRCRCT  D
 . S GMRCRVP=$O(^TMP("GMRC50R",$J,GMRCRCT,""))
 . W !,^TMP("GMRC50R",$J,GMRCRCT,GMRCRVP)
 Q
SELR(GMRCRCT) ;Select a note from the list
 ;Input GMRCNT=array with the count of TIU notes
 I '+$G(GMRCRCT("TIU(8925,")),'+$O(^TMP("GMRC50R",$J,0)) S GMRCMSG="No results available" D EXAC^GMRCADC(GMRCMSG) K GMRCMSG Q 0
 ;Select a note
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR("A")="Select an existing note"
 S DIR(0)="NO^1:"_GMRCRCT("TIU(8925,")
 D ^DIR
 Q +Y
LN1 ;Used by filemanager print template to format line
 S:'$G(COUNT) COUNT=1
 S GMRCVF="TIU(8925,",GMRCNT(GMRCVF)=1,TAB=" "
 S GMRCRVP=+($G(^GMR(123,D0,50,D1,0)))
 Q:'GMRCRVP
 N GMRCDOCT,GMRCEDT
 S GMRCRDAT=$$RESOLVE^TIUSRVLO(+GMRCRVP)
 S GMRCDOCT=$E($P(GMRCRDAT,"^",1),1,19)
 S GMRCEDT=$$FMTE^XLFDT(GMRCRDAT,"D")
 S GMRCTX=$E("#"_+GMRCRVP_TAB,1,9)_$E(GMRCDOCT_TAB,1,22)_$E(GMRCEDT_TAB,1,13)_$P(GMRCRDAT,U,3)
 W GMRCTX
 Q
LN2 ;Used by Fileman to write second line
 N GMRCAUTH,GMRCSTS
 S GMRCAUTH=$E($P($G(^VA(200,+$P(GMRCRDAT,"^",4),0)),U,1),1,12)
 S GMRCSTS=$E($P(GMRCRDAT,"^",6),1,5)
 S GMRCTX=$E(TAB,1,5)_$E("Author: "_GMRCAUTH_TAB,1,16)_$E(GMRCSTS_TAB,1,8)_$E("#"_+$P(GMRCRDAT,"^",9)_TAB,1,10)
 W GMRCTX
 Q
 ;
