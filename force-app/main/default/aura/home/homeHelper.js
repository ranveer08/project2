({
	searchKeyHelper : function(component, event, helper) {
        let searchInput = component.get('v.search');
        let action = component.get('c.showMapHelper');
        action.setParams({'showStatus':searchInput.replace(/\s/g, '%20')});
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state === 'SUCCESS'){
                component.set('v.result',response.getReturnValue());
            }else{
                let errors = response.gerError();
                console.error(errors);
            }
        });
		$A.enqueueAction(action);
	}
})