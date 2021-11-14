import './App.css';
import { Switch, Route } from 'react-router-dom';
import NflTable from './nfltable.jsx';
import React from 'react';

function App() {
  return (
    <div className="App">
      <Switch>
        <Route path="/">
          <NflTable />
        </Route>
        {/* in case more routes needed
        <Route path="/test">
          <Placeholder />
        </Route> */}
      </Switch>
    </div>
  )
}

export default App;
