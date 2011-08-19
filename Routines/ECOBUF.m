ECOBUF ;BP/CMF - Factory Object
 ;;2.0;EVENT CAPTURE;**100,107**;8 May 96;Build 14
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
 ;;
FACTORY0()  Q "^TMP($J,""ECOBUF"")"
 ;;
FACTORY1() Q "^TMP($J,""ECOBUF"",1)"
 ;;
FACTORY2()  ;
 S ^XTMP("ECOBUF",0)=$G(DT)+1_"^"_$G(DT)
 Q "^XTMP(""ECOBUF"","_$S($G(DUZ)'="":DUZ,$G(DT)'="":DT,1:1)_")"
 ;;
VALUE(VALUE) ;;  parse "." out of Parameter values
 Q $S(VALUE="":"",1:$P(VALUE,".")_U_$P(VALUE,".",2,3))
 ;;
 ;; published methods
FACTORY(RESULT,ARGUMENT) ; wrapper for factory methods - RPC "EC OBU FACTORY"
 N FACTORY,HANDLE,CREATE,DESTROY,CLASS,NAME,TARGET
 N ARG1,ARG2,ARG3
 S RESULT="-1^Invalid Factory Parameters",RESULT(0)=RESULT
 S ARGUMENT=$G(ARGUMENT)
 Q:ARGUMENT=""
 S ARG1=$P(ARGUMENT,".",1)
 S ARG2=$P(ARGUMENT,".",2)
 S ARG3=$P(ARGUMENT,".",3)
 S ARG3=$S(ARG3'="":ARG3,ARG1="Constructor"&(ARG3=""):$$FACTORY2(),1:"")
 Q:ARG1="Constructor"&(ARG3="")
 I ARG1="Constructor" D  Q
 .S CLASS=ARG2
 .S NAME=ARG3
 .S CREATE=$$GET^XPAR("PKG","ECOB CONSTRUCTOR",CLASS,"E")
 .I CREATE="" S RESULT(0)="-1^Invalid Class Name" S RESULT=RESULT(0) Q
 .S CREATE="S RESULT=$$"_$$VALUE(CREATE)
 .X CREATE
 .S RESULT(0)=RESULT
 .Q
 I ARG1="Destructor" D  Q
 .S TARGET=ARG2
 .I ARG3'="" S CLASS=ARG3
 .E  D METHOD(.CLASS,TARGET_".of.Get_class")
 .S DESTROY=$$GET^XPAR("PKG","ECOB DESTRUCTOR",CLASS,"E")
 .I DESTROY="" S RESULT(0)="-1^Invalid Class Name" S RESULT=RESULT(0) Q
 .S DESTROY="S RESULT=$$"_$$VALUE(DESTROY)
 .S HANDLE=TARGET
 .X DESTROY
 .S RESULT(0)=RESULT
 .Q
 I ARG1="Method" D  Q
 .D METHOD(.RESULT,$P(ARGUMENT,".",2,99))
 .S RESULT(0)=RESULT
 .Q
 Q
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; call parent last
 D METHOD^ECOBU(.RESULT,ARGUMENT)  ; parent method
 S RESULT(0)=RESULT
 Q
METHODS(RESULT,ARGUMENT)  ;
 ; call parent last
 D METHOD^ECOBU(.RESULT,ARGUMENT)  ; parent method
 Q
OUT(ARGUMENT) ;method call as function
 N RESULT
 D METHOD(.RESULT,ARGUMENT)
 Q RESULT
