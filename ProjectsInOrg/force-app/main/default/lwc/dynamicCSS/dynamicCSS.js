import { LightningElement } from 'lwc';

export default class DynamicCSS extends LightningElement {

    dynamicCSS="DynamicCSS1";

    handleClick(event)
    {
        if(event.target.name == "green")
        {
            this.dynamicCSS = "DynamicCSS2";
        }
        else if(event.target.name == "red")
        {
            this.dynamicCSS = "DynamicCSS1";
        }
    }

}