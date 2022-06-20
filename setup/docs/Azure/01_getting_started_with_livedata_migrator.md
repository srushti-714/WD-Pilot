# Getting started with Wandisco LiveData Migrator for Azure

## Overview

LiveData Migrator for Azure moves data from on-premises Hadoop to Azure Data Lake Storage Gen2.

This lab environment contains a sample Hadoop environment and all the components necessary to experience LiveData Migrator. In this lab, you will login to an Azure subscription with a preconfigured Resource Group, Storage
Account and Container.

## Tasks Included

In this hands-on lab you will perform the following tasks:

- **Task 1: Login to Azure Portal**
- **Task 2: Getting Started with the pre-deployed Hadoop Environment**
- **Task 3: Deploy and use LiveData Migrator for Azure to demonstrate actively changing data from a Hadoop cluster to an ADLS Gen2 account**
- **Task 4: Interact with data from the Hadoop environment and show how easy it is to use the system to effectively migrate your data**

  

# Task 1: Access the PaloAlto Networks Dashboard

## Overview

In this lab, you will be able to access the paloAlto Network Dashboard and explore various options in it.

1. Let us start by logging into the **PaloAlto Networks** page. Copy the link for **PaloAltoVMseriesURL** : <inject key="VMseriesURL"></inject>, open it in a new tab in your browser.

1. If the page is showing like **Your connection isn't private**, on that page click on **Advanced**.
    
    ![](../images/image03.png)
     
1. Select the link under the **Advanced**.

    ![](../images/image04.png)
   
1. On the page that loads up, enter the **PaloaltoUsername** : <inject key="PaloaltoUsername"></inject>, **PaloaltoPassword** : <inject key="PaloaltoPassword"></inject>  and click on Log in.

     ![](../images/Palo01.png)

1. Now, you will be redirected to the dashboard to the **PaloAlto Networks**.

1. The dashboard provides a detailed visual summary of the device status.

     ![](../images/Palo02.png)
     
> Note: Since it is a new firewall, it doesn't have any traffic yet and can view the dashboard at the end.



# Task 2: Login to Azure Portal

## Overview

In this task you will login to Microsoft Azure using your credentials and access the Azure Portal dashboard.

1. In the LabVM desktop, select the **Azure Portal** icon to access the Azure Portal.

1. On **Sign in to Microsoft Azure** blade, you will see a login screen, in that enter the following email/username and then click on **Next**.

    * **Azure Username/Email**: <inject key="AzureAdUserEmail"></inject> 
    * **Azure Password**: <inject key="AzureAdUserPassword"></inject>
    
    >Note: Refer to the **Environment Details** tab for any other lab credentials/details.
        
   ![](../images/image-004.jpg)
    
   ![](../images/image-005.jpg)
   
1. If you see the pop-up like below, click **Skip for now(14 days until this is required)**.

     ![](../images/image004.png)

1. If you see the pop-up **Stay signed in?** Click **Yes**.

    ![](../images/image-006.jpg)
    
1. If a **Welcome to Microsoft Azure** popup window appears, click **Maybe Later** to skip the tour.

    ![](../images/image-007.jpg)
    
1. Now will now see the Azure Portal Dashboard.



## Task 3: Getting started with the Azure Portal

## Overview

In this task, you will navigate to your resource group and view the pre-deployed resources.

1. On the Azure Portal, click on the **Show Menu** button.

     ![](../images/image01.png)

1. Click on the **Resource groups** button in the Menu navigation bar, to view the Resource groups blade.

     ![](../images/Picture2.jpg)

1. On the Resource group blade, select the resource group with **paloalto-DID**.

1. You can view the deployed resources in that resource group **paloalto-DID**.

     ![](../images/image035.png)
     
1. You can view the **Network Interfaces**. 

     * **FWeth0** - This is the management interface

     * **FWeth1** - This network interface is in the untrust zone

     * **FWeth2** - This network interface is in the trust zone
   
     ![](../images/image036.png)

     >Note : You can learn more about untrust and trust zone in the next section of the lab

1. You can view the **Network security group** namely **DefaultNSG**.

    * The Network security group specifies the rules that allows and deny access to the resources within the specific resource group.

1. You can view the Inbound and Outbound security rules of the defaultNSG..

    ![](../images/image043.png)
    
    ![](../images/image044.png)
    
1. The **User defines Routes(UDR)** enables the VM-series Firewall to secure the resource group

    ![](../images/image045.png)
    


    
# Summary
In this task you have 

# Congratulations, you have successfully completed the lab
