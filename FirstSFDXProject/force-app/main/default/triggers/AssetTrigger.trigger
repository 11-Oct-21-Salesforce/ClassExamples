trigger AssetTrigger on Asset (after insert) {
	List<Asset> assets = [SELECT Id FROM Asset WHERE Id IN :Trigger.new];
}