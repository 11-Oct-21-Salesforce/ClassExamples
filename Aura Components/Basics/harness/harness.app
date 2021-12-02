<!-- 
	our Lightning Applications start and end with the <aura:application> tags
	Lightning Applications differ from Lightning Aura components in that they are given a url so we can
	view them separately

	we frequently make use of Lightning Apps during development to preview our components while we're writing
	them
		these are called harness apps and its common to name them harness.app
-->
<aura:application >
    <!-- 
		to instantiate a component inside of a Lightning App or another component, we use the following tag
  			it takes the form <namespace:componentName/>
			the default namespace assigned to us by Salesforce is the c namespace
 	-->
    <c:simpleButton></c:simpleButton>
</aura:application>