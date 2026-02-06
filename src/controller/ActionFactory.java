package controller;

import controller.action.AddChatAction;
import controller.action.AddProductAction;
import controller.action.BidAction;
import controller.action.BuyListAction;
import controller.action.CategoryAction;
import controller.action.DeleteMyInfoAction;
import controller.action.FindIDAction;
import controller.action.FindPWAction;
import controller.action.GetChatAction;
import controller.action.GetChatListAction;
import controller.action.GetNotiListAction;
import controller.action.GetUnreadAction;
import controller.action.HopeAction;
import controller.action.IdCheckAction;
import controller.action.JoinAction;
import controller.action.LoginAction;
import controller.action.LogoutAction;
import controller.action.MyPointAction;
import controller.action.NickCheckAction;
import controller.action.ReportAction;
import controller.action.SearchAction;
import controller.action.SellListAction;
import controller.action.SessionNickCheckAction;
import controller.action.SetMyInfoAction;
import controller.action.SetPWAction;
import controller.action.SetRateAction;
import controller.action.SortAction;
import controller.page.AddProductUI;
import controller.page.BuyListUI;
import controller.page.ChatListUI;
import controller.page.ChatUI;
import controller.page.ErrorUI;
import controller.page.FindIDUI;
import controller.page.FindPWUI;
import controller.page.JoinUI;
import controller.page.LoginUI;
import controller.page.MainManagerUI;
import controller.page.MainUI;
import controller.page.NotiUI;
import controller.page.ProductInfoUI;
import controller.page.SellListUI;
import controller.page.SetMyInfoUI;
import controller.page.SetPWUI;
import controller.page.myPageUI;

public class ActionFactory {
	ActionFactory(){}
	
	static Action getAction(String cmd){
		Action action = null;
		switch (cmd) {
			case "loginUI" :
				action = new LoginUI();
				break;
			case "loginAction" :
				action = new LoginAction();
				break;
			case "joinAction" :
				action = new JoinAction();
				break;
			case "joinUI" :
				action = new JoinUI();
				break;
			case "mainUI" :
				action = new MainUI();
				break;
			case "mainManagerUI" :
				action = new MainManagerUI();
				break;
			case "setRateAction" :
				action = new SetRateAction();
				break;
			case "chatListUI" :
				action = new ChatListUI();
				break;
			case "chatUI" :
				action = new ChatUI();
				break;
			case "addChatAction" :
				action = new AddChatAction();
				break;
			case "getUnreadAction" :
				action = new GetUnreadAction();
				break;
			case "getChatAction" :
				action = new GetChatAction();
				break;
			case "getChatListAction" :
				action = new GetChatListAction();
				break;
			case "addProductUI" :
				action = new AddProductUI();
				break;
			case "addProductAction" :
				action = new AddProductAction();
				break;
			case "notiUI" :
				action = new NotiUI();
				break;
			case "sortAction":
				action = new SortAction();
				break;
			case "productInfoUI":
				action = new ProductInfoUI();
				break;
			case "setMyInfoAction" :
				action = new SetMyInfoAction();
				break;
			case "setMyInfoUI" :
				action = new SetMyInfoUI();
				break;
			case "logoutAction" :
				action = new LogoutAction();
				break;
			case "deleteMyInfoAction" :
				action = new DeleteMyInfoAction();
				break;
			case "findIDUI" :
				action = new FindIDUI();
				break;
			case "findIDAction" :
				action = new FindIDAction();
				break;	
			case "setPWUI" :
				action = new SetPWUI();
				break;
			case "setPWAction" :
				action = new SetPWAction();
				break;	
			case "categoryAction":
				action = new CategoryAction();
				break;
			case "hopeAction":
				action = new HopeAction();
				break;
			case "searchAction":
				action = new SearchAction();
				break;
			case "sellListUI" :
				action = new SellListUI();
				break;				
			case "sellListAction" :
				action = new SellListAction();
				break;
			case "buyListUI" :
				action = new BuyListUI();
				break;
			case "buyListAction" :
				action = new BuyListAction();
				break;
			case "bidAction":
				action = new BidAction();
				break;
			case "findPWUI" :
				action = new FindPWUI();
				break;
			case "findPWAction" :
				action = new FindPWAction();
				break;
			case "myPointAction" :
				action = new MyPointAction();
				break;
			case "myPageUI" :
				action = new myPageUI();
				break;		
			case "idCheckAction" :
				action = new IdCheckAction();
				break;
			case "reportAction":
				action = new ReportAction();
				break;
			case "nickCheckAction" :
				action = new NickCheckAction();
				break;
			case "getNotiListAction" :
				action = new GetNotiListAction();
				break;
			case "sessionNickCheckAction":
				action = new SessionNickCheckAction();
				break;
			default:
				action = new ErrorUI();
				break;
		}
		
		
		return action;
	}
}
