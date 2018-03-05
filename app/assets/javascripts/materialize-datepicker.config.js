$(document).ready(function() {
  (function($) {
    window.materializeForm.initDate = function() {
      $("input.date").pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 2, // Creates a dropdown of 15 years to control year
        labelMonthNext: "Proximo mês",
        labelMonthPrev: "Mês a  nterior",
        labelMonthSelect: "Selecione um mês",
        labelYearSelect: "Selecione um ano",
        monthsFull: [
          "Janeiro",
          "Fevereiro",
          "Marco",
          "Abril",
          "Maio",
          "Junho",
          "Julho",
          "Agosto",
          "Setembro",
          "Outubro",
          "Novembro",
          "Dezembro"
        ],
        monthsShort: [
          "Jan",
          "Fev",
          "Mar",
          "Abr",
          "Mai",
          "Jun",
          "Jul",
          "Ago",
          "Set",
          "Out",
          "Nov",
          "Dez"
        ],
        weekdaysFull: [
          "Segunda-feira",
          "Terça-feira",
          "Quarta-feira",
          "Quinta-feira",
          "Sexta-feira",
          "Sábado",
          "Domingo"
        ],
        weekdaysShort: ["Seg", "Ter", "Qua", "Qui", "Sex", "Sab", "Dom"],
        weekdaysLetter: ["D", "S", "T", "Q", "Q", "S", "S"],
        today: "Hoje",
        clear: "Limpar",
        close: "Fechar",
        format: "dd/mm/yyyy"
      });
    };
  })(jQuery);        
});
