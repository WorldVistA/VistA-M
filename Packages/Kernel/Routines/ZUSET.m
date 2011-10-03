ZUSET ;ISF/RWF - Used to rename the correct routine to ZU ;06/03/2002  14:30
 ;;8.0;KERNEL;**162,170,225,275**;Jul 10, 1995
 N RTN
 W !,"This routine will rename the correct routine to ZU for you."
 S RTN=$$CHK() I '$L(RTN) W !,"Don't know what to do." Q
 W !!,"Rename ",RTN," to ZU, OK? No//" R X:$G(DTIME,60) S:'$L(X) X="N"
 I "yY"'[$E(X) D BMES^XPDUTL("No routine renamed") Q
 D DO(RTN),BMES^XPDUTL("Routine "_RTN_" was renamed to ZU")
 Q
CHK() ;Check what routine to use
 N % S %=^%ZOSF("OS")
 I %["DSM" Q "ZUVXD"
 I %["OpenM" Q "ZUONT"
 I %["MSM" Q "ZUMSM"
 I %["GT.M" Q "ZUGTM"
 Q ""
DO(%) ;Do the rename
 N DIF,XCNT,X
 K ^TMP($J)
 S DIF="^TMP($J,",XCNP=0,X=% X ^%ZOSF("LOAD")
 S DIE="^TMP($J,",XCN=0,X="ZU" X ^%ZOSF("SAVE")
 K ^TMP($J)
 Q
POST ;Called as a post init
 N RTN S RTN=$$CHK()
 I '$L(RTN) D BMES^XPDUTL("No routine renamed") Q
 D DO(RTN),BMES^XPDUTL("Routine "_RTN_" was renamed to ZU")
 Q
