IBDEI0H1 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17106,1,3,0)
 ;;=3^Spinal Stenosis, lumbar region
 ;;^UTILITY(U,$J,358.3,17106,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,17106,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,17107,0)
 ;;=J32.9^^73^864^7
 ;;^UTILITY(U,$J,358.3,17107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17107,1,3,0)
 ;;=3^Sinusitis,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,17107,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,17107,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,17108,0)
 ;;=M48.02^^73^864^13
 ;;^UTILITY(U,$J,358.3,17108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17108,1,3,0)
 ;;=3^Spinal stenosis, cervical region
 ;;^UTILITY(U,$J,358.3,17108,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,17108,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,17109,0)
 ;;=M48.04^^73^864^15
 ;;^UTILITY(U,$J,358.3,17109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17109,1,3,0)
 ;;=3^Spinal stenosis, thoracic region
 ;;^UTILITY(U,$J,358.3,17109,1,4,0)
 ;;=4^M48.04
 ;;^UTILITY(U,$J,358.3,17109,2)
 ;;=^5012091
 ;;^UTILITY(U,$J,358.3,17110,0)
 ;;=M48.00^^73^864^14
 ;;^UTILITY(U,$J,358.3,17110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17110,1,3,0)
 ;;=3^Spinal stenosis, site unspecified
 ;;^UTILITY(U,$J,358.3,17110,1,4,0)
 ;;=4^M48.00
 ;;^UTILITY(U,$J,358.3,17110,2)
 ;;=^5012087
 ;;^UTILITY(U,$J,358.3,17111,0)
 ;;=S14.109S^^73^864^2
 ;;^UTILITY(U,$J,358.3,17111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17111,1,3,0)
 ;;=3^Sequela of Unspec Injury of Cervical Spinal Cord
 ;;^UTILITY(U,$J,358.3,17111,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,17111,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,17112,0)
 ;;=S24.109S^^73^864^4
 ;;^UTILITY(U,$J,358.3,17112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17112,1,3,0)
 ;;=3^Sequela of Unspec Injury of Thoracic Spinal Cord
 ;;^UTILITY(U,$J,358.3,17112,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,17112,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,17113,0)
 ;;=S34.109S^^73^864^3
 ;;^UTILITY(U,$J,358.3,17113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17113,1,3,0)
 ;;=3^Sequela of Unspec Injury of Lumbar Spinal Cord
 ;;^UTILITY(U,$J,358.3,17113,1,4,0)
 ;;=4^S34.109S
 ;;^UTILITY(U,$J,358.3,17113,2)
 ;;=^5134570
 ;;^UTILITY(U,$J,358.3,17114,0)
 ;;=I69.328^^73^864^11
 ;;^UTILITY(U,$J,358.3,17114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17114,1,3,0)
 ;;=3^Speech/Lang Deficits following Cerebvasc Infarc
 ;;^UTILITY(U,$J,358.3,17114,1,4,0)
 ;;=4^I69.328
 ;;^UTILITY(U,$J,358.3,17114,2)
 ;;=^5007495
 ;;^UTILITY(U,$J,358.3,17115,0)
 ;;=F20.2^^73^865^3
 ;;^UTILITY(U,$J,358.3,17115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17115,1,3,0)
 ;;=3^Schizophrenia, catatonic
 ;;^UTILITY(U,$J,358.3,17115,1,4,0)
 ;;=4^F20.2
 ;;^UTILITY(U,$J,358.3,17115,2)
 ;;=^5003471
 ;;^UTILITY(U,$J,358.3,17116,0)
 ;;=F20.1^^73^865^4
 ;;^UTILITY(U,$J,358.3,17116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17116,1,3,0)
 ;;=3^Schizophrenia, disorganized
 ;;^UTILITY(U,$J,358.3,17116,1,4,0)
 ;;=4^F20.1
 ;;^UTILITY(U,$J,358.3,17116,2)
 ;;=^5003470
 ;;^UTILITY(U,$J,358.3,17117,0)
 ;;=F20.0^^73^865^5
 ;;^UTILITY(U,$J,358.3,17117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17117,1,3,0)
 ;;=3^Schizophrenia, paranoid
 ;;^UTILITY(U,$J,358.3,17117,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,17117,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,17118,0)
 ;;=F20.5^^73^865^6
 ;;^UTILITY(U,$J,358.3,17118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17118,1,3,0)
 ;;=3^Schizophrenia, residual
 ;;^UTILITY(U,$J,358.3,17118,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,17118,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,17119,0)
 ;;=F25.9^^73^865^1
 ;;^UTILITY(U,$J,358.3,17119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17119,1,3,0)
 ;;=3^Schizoaffective disorder, unspec
 ;;^UTILITY(U,$J,358.3,17119,1,4,0)
 ;;=4^F25.9
 ;;^UTILITY(U,$J,358.3,17119,2)
 ;;=^331857
 ;;^UTILITY(U,$J,358.3,17120,0)
 ;;=F20.9^^73^865^7
 ;;^UTILITY(U,$J,358.3,17120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17120,1,3,0)
 ;;=3^Schizophrenia, unspec
 ;;^UTILITY(U,$J,358.3,17120,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,17120,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,17121,0)
 ;;=F20.81^^73^865^8
 ;;^UTILITY(U,$J,358.3,17121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17121,1,3,0)
 ;;=3^Schizophreniform disorder
 ;;^UTILITY(U,$J,358.3,17121,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,17121,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,17122,0)
 ;;=F60.1^^73^865^2
 ;;^UTILITY(U,$J,358.3,17122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17122,1,3,0)
 ;;=3^Schizoid personality disorder
 ;;^UTILITY(U,$J,358.3,17122,1,4,0)
 ;;=4^F60.1
 ;;^UTILITY(U,$J,358.3,17122,2)
 ;;=^108271
 ;;^UTILITY(U,$J,358.3,17123,0)
 ;;=Z11.1^^73^866^3
 ;;^UTILITY(U,$J,358.3,17123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17123,1,3,0)
 ;;=3^Screening for Resp Tuberculosis
 ;;^UTILITY(U,$J,358.3,17123,1,4,0)
 ;;=4^Z11.1
 ;;^UTILITY(U,$J,358.3,17123,2)
 ;;=^5062670
 ;;^UTILITY(U,$J,358.3,17124,0)
 ;;=Z13.89^^73^866^2
 ;;^UTILITY(U,$J,358.3,17124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17124,1,3,0)
 ;;=3^Screening for Other Disorders
 ;;^UTILITY(U,$J,358.3,17124,1,4,0)
 ;;=4^Z13.89
 ;;^UTILITY(U,$J,358.3,17124,2)
 ;;=^5062720
 ;;^UTILITY(U,$J,358.3,17125,0)
 ;;=Z12.9^^73^866^1
 ;;^UTILITY(U,$J,358.3,17125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17125,1,3,0)
 ;;=3^Screening for Malig Neop,Site Unspec
 ;;^UTILITY(U,$J,358.3,17125,1,4,0)
 ;;=4^Z12.9
 ;;^UTILITY(U,$J,358.3,17125,2)
 ;;=^5062698
 ;;^UTILITY(U,$J,358.3,17126,0)
 ;;=F10.10^^73^867^1
 ;;^UTILITY(U,$J,358.3,17126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17126,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17126,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,17126,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,17127,0)
 ;;=F10.20^^73^867^3
 ;;^UTILITY(U,$J,358.3,17127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17127,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17127,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,17127,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,17128,0)
 ;;=F10.229^^73^867^2
 ;;^UTILITY(U,$J,358.3,17128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17128,1,3,0)
 ;;=3^Alcohol dependence w/ intoxctn, unspec
 ;;^UTILITY(U,$J,358.3,17128,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,17128,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,17129,0)
 ;;=F12.10^^73^867^4
 ;;^UTILITY(U,$J,358.3,17129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17129,1,3,0)
 ;;=3^Cannabis abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17129,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,17129,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,17130,0)
 ;;=F12.20^^73^867^5
 ;;^UTILITY(U,$J,358.3,17130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17130,1,3,0)
 ;;=3^Cannabis dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17130,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,17130,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,17131,0)
 ;;=F14.10^^73^867^6
 ;;^UTILITY(U,$J,358.3,17131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17131,1,3,0)
 ;;=3^Cocaine abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17131,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,17131,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,17132,0)
 ;;=F14.20^^73^867^7
 ;;^UTILITY(U,$J,358.3,17132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17132,1,3,0)
 ;;=3^Cocaine dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,17132,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,17132,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,17133,0)
 ;;=F16.10^^73^867^8
 ;;^UTILITY(U,$J,358.3,17133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17133,1,3,0)
 ;;=3^Hallucinogen abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,17133,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,17133,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,17134,0)
 ;;=F16.20^^73^867^9
 ;;^UTILITY(U,$J,358.3,17134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17134,1,3,0)
 ;;=3^Hallucinogen dependence, uncomplicated
