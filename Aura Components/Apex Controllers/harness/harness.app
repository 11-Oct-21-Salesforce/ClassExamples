<!-- just a simple harness app to view our componen    
	here, we extend the force:slds class in our harness app, not our top-level component b/c
	this class is automatically loaded as part of Lightning Experience, so accessing SLDS
	features requires no extra effort from us when we put a component in a Lightning page -->t -->
<aura:application extends="force:slds">
    <c:apexControllerDemo></c:apexControllerDemo>
</aura:application>