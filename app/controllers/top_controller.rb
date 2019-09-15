class TopController < ApplicationController
  def jp
    @current_balance = params[:current_balance].to_d                                     #元本
    @monthly_addition = params[:monthly_addition].to_d                                   #毎月積立金額
    @interest_rate_year = params[:interest_rate_year].to_d                               #年利
    @period_year = params[:period_year].to_i                                             #投資期間

    #cookieに保持
    cookies[:current_balance] = params[:current_balance]
    cookies[:monthly_addition] = params[:monthly_addition]
    cookies[:interest_rate_year] = params[:interest_rate_year]
    cookies[:period_year] = params[:period_year]

    @interest_rate_month = (1+(@interest_rate_year/100))**(0.08333)                      #月利。1/12=0.083333
    @getsuri = ((@interest_rate_month-1)*100).round(2)                                   #画面表示用月利
    @ganpon = params[:current_balance].to_i                                              #画面表示用元本
    @tsumitate = params[:monthly_addition].to_i                                          #画面表示用積立

    x_years = [ *0..@period_year ]                                                       #グラフx軸　投資年数
    asshole_final_balance = []                                                           #タンス預金
    simple_interest_balance = []                                                         #単利資産
    compound_interest_balance = []                                                       #複利資産
    compound_calculation_balance = []                                                    #複利計算用配列

    #INITIALIZE
    asshole_final_balance[0] = @current_balance
    simple_interest_balance[0] = @current_balance
    compound_interest_balance[0] = @current_balance
    compound_calculation_balance[0] = @current_balance


    #計算処理
    monthly_compound_count = 1
    compound_count = 1
    while monthly_compound_count < @period_year*12 + 1
      compound_calculation_balance[monthly_compound_count] = ((compound_calculation_balance[monthly_compound_count-1]+@monthly_addition)*@interest_rate_month)
      if monthly_compound_count % 12 == 0 then
        #タンス預金
        asshole_final_balance[compound_count] = @ganpon+(@tsumitate*12*compound_count)
        #単利計算
        simple_interest_balance[compound_count] = @ganpon+(@tsumitate*12*compound_count)+(@current_balance*@interest_rate_year/100*compound_count)
        #複利計算
        compound_interest_balance[compound_count] = compound_calculation_balance[monthly_compound_count].ceil(2)
        #カウントインクリメント
        compound_count += 1
      end
      monthly_compound_count += 1
    end

    #画面表示数量
    @simple_final_balance = simple_interest_balance[simple_count-1].round(1).to_d
    @compound_final_balance = compound_interest_balance[compound_count-1].round(1).to_d
    @no_investment_final_balance = asshole_final_balance[simple_count-1].round(1).to_d
    @rate_of_increase_decimel = ((@compound_final_balance-@no_investment_final_balance)/@no_investment_final_balance*100).round(1).to_d
    if @rate_of_increase_decimel >= 0
      @rate_of_increase = '+ '+@rate_of_increase_decimel.to_s
    else
      @rate_of_increase = '- '+(@rate_of_increase_decimel*(-1)).to_s
    end





    #グラフ
    @chart = LazyHighCharts::HighChart.new('graph') do |c|
      c.title(text: '運用実績')
      c.xAxis(categories: x_years, title: {text: '年'})
      c.series(name: '貯金', data: asshole_final_balance.map!(&:to_i))
      c.series(name: '単利', data: simple_interest_balance.map!(&:to_i))
      c.series(name: '複利', data: compound_interest_balance.map!(&:to_i))
      c.legend(verticalAlign: 'top', y: 25, layout: 'vertical')
#      c.yAxis(title: {text: '万円'})
#     c.chart(type: 'column')
    end
  end

  def en
    @current_balance_en = params[:current_balance_en].to_d                                     #元本
    @monthly_addition_en = params[:monthly_addition_en].to_d                                   #毎月積立金額
    @interest_rate_year_en = params[:interest_rate_year_en].to_d                               #年利
    @period_year_en = params[:period_year_en].to_i                                             #投資期間

    #cookieに保持
    cookies[:current_balance_en] = params[:current_balance_en]
    cookies[:monthly_addition_en] = params[:monthly_addition_en]
    cookies[:interest_rate_year_en] = params[:interest_rate_year_en]
    cookies[:period_year_en] = params[:period_year_en]

    @interest_rate_month_en = (1+(@interest_rate_year_en/100))**(0.08333)                      #月利。1/12=0.083333
    @getsuri_en = ((@interest_rate_month_en-1)*100).round(2)                                   #画面表示用月利
    @ganpon_en = params[:current_balance_en].to_i                                              #画面表示用元本
    @tsumitate_en = params[:monthly_addition_en].to_i                                          #画面表示用積立

    x_years_en = [ *0..@period_year_en ]                                                       #グラフx軸　投資年数
    asshole_final_balance_en = []                                                              #タンス預金
    simple_interest_balance_en = []                                                            #単利資産
    compound_interest_balance_en = []                                                          #複利資産
    compound_calculation_balance_en = []                                                       #複利計算用配列

    #INITIALIZE
    asshole_final_balance_en[0] = @current_balance_en
    simple_interest_balance_en[0] = @current_balance_en
    compound_interest_balance_en[0] = @current_balance_en
    compound_calculation_balance_en[0] = @current_balance_en


    #計算処理
    monthly_compound_count_en = 1
    compound_count_en = 1
    while monthly_compound_count_en < @period_year_en*12 + 1
      compound_calculation_balance_en[monthly_compound_count_en] = ((compound_calculation_balance_en[monthly_compound_count_en-1]+@monthly_addition_en)*@interest_rate_month_en)
      if monthly_compound_count_en % 12 == 0 then

        #タンス預金
        asshole_final_balance_en[compound_count_en] = @ganpon_en+(@tsumitate_en*12*compound_count_en)
        #単利計算
        simple_interest_balance_en[simple_count_en] = @ganpon_en+(@tsumitate_en*12*simple_count_en)+(@current_balance_en*@interest_rate_year_en/100*simple_count_en)
        #複利計算
        compound_interest_balance_en[compound_count_en] = compound_calculation_balance_en[monthly_compound_count_en].ceil(2)
        #カウントインクリメント
        compound_count_en += 1
      end
      monthly_compound_count_en += 1
    end

    #画面表示数量
    @simple_final_balance_en = simple_interest_balance_en[simple_count_en-1].round(1).to_d
    @compound_final_balance_en = compound_interest_balance_en[compound_count_en-1].round(1).to_d
    @no_investment_final_balance_en = asshole_final_balance_en[tansu_count_en-1].round(1).to_d
    @rate_of_increase_decimel_en = ((@compound_final_balance_en-@no_investment_final_balance_en)/@no_investment_final_balance_en*100).round(1).to_d
    if @rate_of_increase_decimel_en >= 0
      @rate_of_increase_en = '+ '+@rate_of_increase_decimel_en.to_s
    else
      @rate_of_increase_en = '- '+(@rate_of_increase_decimel_en*(-1)).to_s
    end



    #グラフ
    @chart_en = LazyHighCharts::HighChart.new('graph') do |c_en|
      c_en.title(text: 'Money Chart')
      c_en.xAxis(categories: x_years_en, title: {text: 'year'})
      c_en.series(name: 'no invest', data: asshole_final_balance_en.map!(&:to_i))
      c_en.series(name: 'simple interest', data: simple_interest_balance_en.map!(&:to_i))
      c_en.series(name: 'compound interest', data: compound_interest_balance_en.map!(&:to_i))
      c_en.yAxis(title: {text: '$'})
#     c_en.chart(type: 'column')
    end
  end
end
