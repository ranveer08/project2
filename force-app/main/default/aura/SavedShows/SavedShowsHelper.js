({
	displayShowFromDb : function(component, event) {
        let action = component.get("c.getShowFromDb");
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
                console.log(action);
                component.set("v.disShow", response.getReturnValue());
            }
        })
        $A.enqueueAction(action);
		
	}
})