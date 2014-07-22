trigger HandleProductPriceChange on Merchandise__c (after update) {
	// update invoice line items associated with open invoices
	List<Line_Item__c> OpenLineItems = 
	[SELECT j.Unit_Price__c, j.Merchandise__r.Price__c
	From Line_Item__c j
	Where j.Invoice_Statement__r.Status__c = 'Negotiating' and
	j.Merchandise__r.id IN :Trigger.new For UPDATE];
	
	for(Line_Item__c li: OpenLineItems){
		if(li.Merchandise__r.price__c < li.unit_price__c){
			li.unit_price__c = li.Merchandise__r.price__c;
		}
	}
	
	update openLineItems;

}